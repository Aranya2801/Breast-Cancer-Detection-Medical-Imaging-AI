# ═══════════════════════════════════════════════════════════
# Breast Cancer Detection Medical Imaging AI — Makefile
# ═══════════════════════════════════════════════════════════

.PHONY: install install-dev train eval dashboard api docker test lint clean help

PYTHON  = python
PIP     = pip
CONFIG  = configs/config.yaml

help:
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo "  Breast Cancer Detection AI — Available Commands"
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo "  make install      Install all dependencies"
	@echo "  make install-dev  Install + dev tools"
	@echo "  make data         Download all datasets"
	@echo "  make train        Train the ensemble model"
	@echo "  make train-debug  Quick debug training (2 epochs)"
	@echo "  make eval         Evaluate on test set"
	@echo "  make dashboard    Launch Streamlit dashboard"
	@echo "  make api          Launch FastAPI server"
	@echo "  make docker-up    Start full Docker stack"
	@echo "  make test         Run pytest suite"
	@echo "  make lint         Run linters"
	@echo "  make clean        Remove build artifacts"
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

install:
	$(PIP) install --upgrade pip
	$(PIP) install torch torchvision --index-url https://download.pytorch.org/whl/cu121
	$(PIP) install -r requirements.txt

install-dev: install
	$(PIP) install black flake8 isort mypy pytest pytest-cov pytest-asyncio

install-cpu:
	$(PIP) install --upgrade pip
	$(PIP) install torch torchvision --index-url https://download.pytorch.org/whl/cpu
	$(PIP) install -r requirements.txt

data:
	$(PYTHON) scripts/prepare_dataset.py --all

data-cbis:
	$(PYTHON) scripts/prepare_dataset.py --dataset cbis_ddsm

train:
	$(PYTHON) scripts/train.py --config $(CONFIG)

train-debug:
	$(PYTHON) scripts/train.py --config $(CONFIG) --debug

train-wandb:
	$(PYTHON) scripts/train.py --config $(CONFIG) --wandb

eval:
	$(PYTHON) scripts/evaluate.py --weights weights/best_model.pt --csv data/processed/dataset.csv

eval-tta:
	$(PYTHON) scripts/evaluate.py --weights weights/best_model.pt --csv data/processed/dataset.csv --tta

export-onnx:
	$(PYTHON) scripts/export_model.py --weights weights/best_model.pt --format onnx

export-all:
	$(PYTHON) scripts/export_model.py --weights weights/best_model.pt --format all

dashboard:
	streamlit run app/dashboard.py --server.port 8501

api:
	uvicorn src.api.server:app --host 0.0.0.0 --port 8000 --reload --log-level info

api-prod:
	uvicorn src.api.server:app --host 0.0.0.0 --port 8000 --workers 4

docker-build:
	docker-compose build

docker-up:
	docker-compose up --build

docker-down:
	docker-compose down

docker-gpu:
	docker-compose --profile gpu up --build

test:
	pytest tests/ -v --cov=src --cov-report=term-missing --cov-report=html

test-fast:
	pytest tests/ -v -x -q

benchmark:
	$(PYTHON) scripts/benchmark.py --device cpu --n_iters 20

lint:
	black src/ app/ tests/ --line-length 120
	isort src/ app/ tests/
	flake8 src/ app/ tests/ --max-line-length=120 --ignore=E501,W503

lint-check:
	black --check src/ app/ tests/ --line-length 120
	isort --check-only src/ app/ tests/
	flake8 src/ app/ tests/ --max-line-length=120

notebooks:
	jupyter lab notebooks/

clean:
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	rm -rf build/ dist/ *.egg-info/ htmlcov/ .coverage
	@echo "Clean complete"

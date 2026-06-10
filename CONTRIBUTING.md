# Contributing to Breast Cancer Detection Medical Imaging AI

Thank you for your interest in contributing! This guide covers everything you need to get started.

---

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Development Setup](#development-setup)
- [Coding Standards](#coding-standards)
- [Testing Guidelines](#testing-guidelines)
- [Pull Request Process](#pull-request-process)
- [Issue Templates](#issue-templates)

---

## 🤝 Code of Conduct

This project follows the [Contributor Covenant](https://www.contributor-covenant.org/) Code of Conduct. By participating, you agree to uphold a welcoming, respectful, and harassment-free community.

---

## 🛠️ How to Contribute

### Types of Contributions Welcome

| Type | Examples |
|---|---|
| 🐛 **Bug Fixes** | Fix preprocessing errors, API crashes, training instability |
| ✨ **New Features** | New XAI methods, backbone models, augmentations |
| 📖 **Documentation** | Improve README, docstrings, notebook explanations |
| 🧪 **Tests** | Add unit/integration tests, increase coverage |
| 📊 **Datasets** | Add support for new mammography datasets |
| 🏥 **Clinical** | Improve BIRADS scoring, clinical reporting |
| ⚡ **Performance** | Speed up inference, reduce memory usage |

---

## 💻 Development Setup

```bash
# 1. Fork the repository on GitHub
# 2. Clone your fork
git clone https://github.com/YOUR_USERNAME/Breast-Cancer-Detection-Medical-Imaging-AI.git
cd Breast-Cancer-Detection-Medical-Imaging-AI

# 3. Add upstream remote
git remote add upstream https://github.com/Aranya2801/Breast-Cancer-Detection-Medical-Imaging-AI.git

# 4. Create virtual environment
conda create -n breastai-dev python=3.11 -y
conda activate breastai-dev

# 5. Install in dev mode
pip install torch torchvision --index-url https://download.pytorch.org/whl/cpu
pip install -r requirements.txt
pip install -e ".[dev]"

# 6. Install pre-commit hooks
pip install pre-commit
pre-commit install
```

### Pre-commit Hooks

Our pre-commit config runs automatically on every commit:
- `black` — code formatting
- `isort` — import sorting  
- `flake8` — linting
- `mypy` — type checking

---

## 📐 Coding Standards

### Python Style

- **Formatter**: `black` with line length 100
- **Imports**: `isort` with profile `black`
- **Type hints**: Required for all public functions
- **Docstrings**: Google-style for all public classes and functions

```python
# ✅ Good
def compute_metrics(
    results: Dict[str, np.ndarray],
    threshold: float = 0.5,
) -> Dict[str, float]:
    """
    Compute classification metrics from model outputs.

    Args:
        results: Dictionary with keys 'labels', 'probs', 'preds'.
        threshold: Decision boundary for binary classification.

    Returns:
        Dictionary mapping metric names to float values.

    Raises:
        ValueError: If results dict is missing required keys.
    """
    ...

# ❌ Bad
def compute_metrics(results, threshold=0.5):
    ...
```

### File Organization

- One class/module per file where possible
- Group related functionality in `src/` subdirectories
- Tests mirror the `src/` structure in `tests/`

---

## 🧪 Testing Guidelines

### Running Tests

```bash
# Full test suite
pytest tests/ -v --cov=src --cov-report=term-missing

# Specific test file
pytest tests/test_all.py::TestLiteModel -v

# Fast tests only (skip slow integration tests)
pytest tests/ -v -m "not slow"
```

### Writing Tests

- Every new feature **must** include tests
- Target **>80% code coverage** for new code
- Use `pytest.fixture` for shared test data
- Use `@pytest.mark.slow` for tests taking >10s

```python
class TestMyNewFeature:
    def test_basic_case(self, dummy_tensor):
        result = my_new_feature(dummy_tensor)
        assert result.shape == expected_shape

    def test_edge_case_empty_input(self):
        with pytest.raises(ValueError):
            my_new_feature(torch.empty(0))

    @pytest.mark.slow
    def test_full_pipeline(self, real_dataset):
        # expensive integration test
        ...
```

---

## 🔁 Pull Request Process

1. **Sync with upstream** before starting:
   ```bash
   git fetch upstream
   git checkout main
   git merge upstream/main
   ```

2. **Create a feature branch**:
   ```bash
   git checkout -b feature/add-score-cam-v2
   # or: fix/preprocessing-dicom-crash
   # or: docs/update-api-reference
   ```

3. **Make changes** following coding standards

4. **Run tests** and ensure they pass:
   ```bash
   pytest tests/ -v
   black src/ app/ tests/
   flake8 src/ app/ tests/ --max-line-length=100
   ```

5. **Commit** with a descriptive message:
   ```bash
   git commit -m "feat(xai): add Score-CAM v2 with batch processing support"
   # Prefixes: feat, fix, docs, test, perf, refactor, chore
   ```

6. **Push and open PR**:
   ```bash
   git push origin feature/add-score-cam-v2
   ```
   Then open a Pull Request on GitHub with:
   - Clear description of what changed and why
   - Link to related issue (if any)
   - Screenshots for UI changes
   - Test results / benchmark comparisons

7. **Address review comments** promptly

8. **PR is merged** after:
   - ✅ CI passes (lint, tests, security scan, docker build)
   - ✅ At least 1 maintainer approval
   - ✅ No unresolved discussions

---

## 🐛 Issue Templates

### Bug Report

```markdown
**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
1. Step 1
2. Step 2
3. Error message / stack trace

**Expected behavior**
What you expected to happen.

**Environment**
- OS: [e.g. Ubuntu 22.04]
- Python: [e.g. 3.11.5]
- PyTorch: [e.g. 2.2.0+cu121]
- GPU: [e.g. NVIDIA RTX 3090]
```

### Feature Request

```markdown
**Is your feature request related to a problem?**
A clear description of the problem.

**Describe the solution you'd like**
What you want to happen.

**Alternatives considered**
Any other approaches you've considered.

**Additional context**
Any relevant papers, links, or screenshots.
```

---

## 📬 Contact

- **GitHub Issues**: Preferred for bugs and feature requests
- **GitHub Discussions**: For questions and ideas
- **Email**: See GitHub profile

---

*Thank you for making BreastAI better for everyone!* 🩺

from setuptools import setup, find_packages
from pathlib import Path

long_description = (Path(__file__).parent / "README.md").read_text(encoding="utf-8")

setup(
    name="breast-cancer-detection-ai",
    version="2.0.0",
    author="Aranya2801",
    description="State-of-the-art breast cancer detection from mammography using 4-backbone ensemble AI",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/Aranya2801/Breast-Cancer-Detection-Medical-Imaging-AI",
    packages=find_packages(exclude=["tests*", "notebooks*", "scripts*"]),
    python_requires=">=3.10",
    install_requires=[
        "torch>=2.2.0",
        "torchvision>=0.17.0",
        "timm>=0.9.12",
        "numpy>=1.26.0",
        "scikit-learn>=1.4.0",
        "pandas>=2.2.0",
        "opencv-python-headless>=4.9.0",
        "Pillow>=10.2.0",
        "albumentations>=1.4.0",
        "pydicom>=2.4.3",
        "fastapi>=0.109.0",
        "uvicorn[standard]>=0.27.0",
        "streamlit>=1.31.0",
        "pyyaml>=6.0.1",
        "tqdm>=4.66.0",
        "matplotlib>=3.8.0",
        "plotly>=5.18.0",
    ],
    extras_require={
        "dev": [
            "pytest>=8.0.0",
            "pytest-asyncio>=0.23.0",
            "pytest-cov>=4.1.0",
            "black>=24.1.0",
            "flake8>=7.0.0",
            "isort>=5.13.0",
            "mypy>=1.8.0",
            "pre-commit>=3.6.0",
        ],
        "xai": ["shap>=0.44.0", "lime>=0.2.0.1"],
        "monitoring": ["wandb>=0.16.0", "prometheus-client>=0.19.0"],
    },
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Science/Research",
        "Intended Audience :: Healthcare Industry",
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
        "Programming Language :: Python :: 3.12",
        "Topic :: Scientific/Engineering :: Artificial Intelligence",
        "Topic :: Scientific/Engineering :: Medical Science Apps.",
    ],
    entry_points={
        "console_scripts": [
            "breastai-train=scripts.train:main",
            "breastai-evaluate=scripts.evaluate:main",
            "breastai-export=scripts.export_model:main",
            "breastai-benchmark=scripts.benchmark:main",
            "breastai-prepare-data=scripts.prepare_dataset:main",
        ]
    },
    project_urls={
        "Bug Reports": "https://github.com/Aranya2801/Breast-Cancer-Detection-Medical-Imaging-AI/issues",
        "Documentation": "https://github.com/Aranya2801/Breast-Cancer-Detection-Medical-Imaging-AI#readme",
        "Source": "https://github.com/Aranya2801/Breast-Cancer-Detection-Medical-Imaging-AI",
    },
)

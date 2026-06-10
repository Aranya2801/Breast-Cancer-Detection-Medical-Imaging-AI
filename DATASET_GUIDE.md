# 📂 Dataset Download Guide

This guide provides **exact steps** to download every supported dataset and upload them to the repo's `data/raw/` folder.

---

## ⚠️ Prerequisites

### 1. Install Kaggle CLI
```bash
pip install kaggle
```

### 2. Set Up Kaggle API Key
1. Go to [https://www.kaggle.com](https://www.kaggle.com) → Account → **Create New API Token**
2. This downloads `kaggle.json`
3. Place it at `~/.kaggle/kaggle.json`
4. Set permissions: `chmod 600 ~/.kaggle/kaggle.json`

---

## 📥 Dataset 1 — CBIS-DDSM (Recommended Start)

**What it is:** Curated Breast Imaging Subset of the Digital Database for Screening Mammography.  
**Size:** ~26 GB | **Cases:** 2,620 | **Format:** PNG (converted from DICOM)

```bash
kaggle datasets download -d awsaf49/cbis-ddsm-breast-cancer-image-dataset -p data/raw/cbis_ddsm --unzip
```

**Direct link:** https://www.kaggle.com/datasets/awsaf49/cbis-ddsm-breast-cancer-image-dataset

**Label mapping:**
| Original | Our Label |
|---|---|
| BENIGN | 0 |
| MALIGNANT | 1 |
| BENIGN_WITHOUT_CALLBACK | 0 |

---

## 📥 Dataset 2 — VinDr-Mammo

**What it is:** Large-scale Vietnamese breast cancer mammography dataset with radiologist annotations.  
**Size:** ~76 GB | **Cases:** 20,000 | **Format:** DICOM

```bash
kaggle datasets download -d awsaf49/vindr-mammo-dataset -p data/raw/vindr_mammo --unzip
```

**Direct link:** https://www.kaggle.com/datasets/awsaf49/vindr-mammo-dataset

**Label mapping (BI-RADS):**
| BI-RADS | Our Label | Description |
|---|---|---|
| 1, 2, 3 | 0 (Benign) | Negative / Benign / Probably Benign |
| 4, 5 | 1 (Malignant) | Suspicious / Highly Suggestive |

---

## 📥 Dataset 3 — INbreast

**What it is:** Full-field digital mammography dataset from Portugal with precise lesion delineations.  
**Size:** ~2 GB | **Cases:** 410 | **Format:** DICOM

```bash
kaggle datasets download -d martholi/inbreast -p data/raw/inbreast --unzip
```

**Direct link:** https://www.kaggle.com/datasets/martholi/inbreast

---

## 📥 Dataset 4 — MIAS (Mini-MIAS)

**What it is:** Classic mammography dataset from the UK. Small but well-annotated.  
**Size:** ~120 MB | **Cases:** 322 | **Format:** PGM (grayscale)

```bash
kaggle datasets download -d kmader/mias-mammography -p data/raw/mias --unzip
```

**Direct link:** https://www.kaggle.com/datasets/kmader/mias-mammography

---

## ⚡ Download Everything at Once

```bash
# Auto-downloads all 4 datasets
python scripts/prepare_dataset.py --all

# This will:
# 1. Download from Kaggle
# 2. Parse labels
# 3. Build unified data/processed/dataset.csv
# 4. Print summary statistics
```

---

## 📊 Expected Output After Download

```
data/
├── raw/
│   ├── cbis_ddsm/      # ~26 GB
│   ├── vindr_mammo/    # ~76 GB
│   ├── inbreast/       # ~2 GB
│   └── mias/           # ~120 MB
└── processed/
    └── dataset.csv     # Unified CSV with all samples
```

**Expected CSV format:**
```
image_path,label,dataset,raw_label
data/raw/cbis_ddsm/img001.png,0,cbis_ddsm,BENIGN
data/raw/cbis_ddsm/img002.png,1,cbis_ddsm,MALIGNANT
data/raw/vindr_mammo/img003.dcm,1,vindr_mammo,BIRADS 4
...
```

---

## 🗜️ Uploading to GitHub

Since datasets are large, **do NOT commit raw data to Git**.  
Instead, use one of these approaches:

### Option A — Git LFS (for files < 2 GB)
```bash
git lfs install
git lfs track "data/processed/*.csv"
git add .gitattributes
git add data/processed/dataset.csv
git commit -m "feat: add processed dataset CSV"
```

### Option B — GitHub Releases (for large files)
1. Go to your repo → **Releases** → **Create a new release**
2. Upload `dataset.csv` or a zip of sample images as a release asset
3. Users download it via the release page

### Option C — Just commit the CSV
The raw images are large but the CSV is small (<5 MB):
```bash
git add data/processed/dataset.csv
git commit -m "feat: add dataset index CSV"
```

---

## 🧪 Using Sample Data (No Download)

If you can't download the full datasets, the notebooks and scripts work with small sample data:

```bash
# Creates 50 synthetic test images
python scripts/prepare_dataset.py --no-download --dataset cbis_ddsm
```

Or run notebooks in **demo mode** — they auto-generate synthetic mammogram data when no CSV is found.

---

## 📋 Dataset Citation

If you use this project in research, please cite the original datasets:

```bibtex
@article{cbis_ddsm,
  title={CBIS-DDSM: Curated Breast Imaging Subset of DDSM},
  author={Lee, Rebecca Sawyer and Gimenez, Francisco and Hoogi, Assaf and Rubin, Daniel},
  journal={Scientific Data},
  year={2017}
}

@article{vindr_mammo,
  title={VinDr-Mammo: A large-scale benchmark dataset for computer-aided diagnosis in full-field digital mammography},
  author={Nguyen, Hieu T and others},
  journal={Scientific Data},
  year={2023}
}

@article{inbreast,
  title={INbreast: Toward a Full-field Digital Mammographic Database},
  author={Moreira, Inês C and others},
  journal={Academic Radiology},
  year={2012}
}
```

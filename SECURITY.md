# Security Policy

## Supported Versions

| Version | Supported |
|---|---|
| 2.0.x | ✅ Active |
| 1.x.x | ❌ EOL |

## Reporting a Vulnerability

Please **do not** open public GitHub issues for security vulnerabilities.

Email: [Create a private security advisory](https://github.com/Aranya2801/Breast-Cancer-Detection-Medical-Imaging-AI/security/advisories/new)

Include:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

We will respond within 72 hours and aim to patch critical issues within 7 days.

## Security Considerations

- This project processes medical images — **never upload real patient data** to public instances
- API endpoints should be behind authentication in production
- Use HTTPS in all production deployments
- Regularly update dependencies with `pip install --upgrade -r requirements.txt`
- The DICOM reader handles untrusted files — do not process files from unknown sources

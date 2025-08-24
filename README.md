# Lab 8: Deploy to Remote Server via Ansible from GitHub Actions

## 🎯 Lab Objectives
- ✅ Trigger Ansible via GitHub Actions
- ✅ Use dawidd6/action-ansible-playbook securely
- ✅ Manage SSH private key as a GitHub secret
- ✅ Deploy to remote server (GitHub Codespace)
- ✅ Debug failed CI/CD deployments

## 🚀 Quick Setup

### 1. Create Codespace
- Create a Codespace from this repository
- Wait for setup to complete
- Copy the SSH private key from terminal output

### 2. Configure GitHub Secrets
- Go to Settings → Secrets and variables → Actions
- Add `SSH_PRIVATE_KEY`: (paste the private key from Codespace)
- Add `CODESPACE_URL`: (your Codespace hostname)

### 3. Test Deployment
- Push code or run workflow manually
- Check Actions tab for deployment progress
- Access deployed app via Codespace forwarded URL

## 🔧 Manual Testing

```bash
# In your Codespace terminal:
gh codespace ports                    # Get forwarded URLs
curl http://localhost:8080/health     # Test locally
sudo supervisorctl status lab8-demo   # Check app status
📊 Application URLs

Main App: http://YOUR-CODESPACE-URL:8080/
Health Check: http://YOUR-CODESPACE-URL:8080/health
Version Info: http://YOUR-CODESPACE-URL:8080/version

🛠️ Tech Stack

GitHub Actions (CI/CD)
Ansible (Configuration Management)
Python Flask (Application)
Nginx (Web Server)
Supervisor (Process Manager)
GitHub Codespaces (Target Server)

🎓 Lab Status
Status: Ready for Testing ✅

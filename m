From: agross@codeaurora.org (Andy Gross)
Date: Fri, 11 Sep 2015 13:07:33 -0500
Subject: [GIT PULL] qcom fixes for 4.3-rc1
Message-ID: <1441994854-32163-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  git at git.codeaurora.org:quic/kernel/agross-msm.git tags/qcom-fixes-for-4.3-rc1

for you to fetch changes up to 100dea902f73d8658655f59b4021cbc3c6c3c957:

  firmware: qcom: scm: Add function stubs for ARM64 (2015-09-11 11:59:31 -0500)

----------------------------------------------------------------
Qualcomm fixes for v4.3-rc1

* Add SCM function call stubs on ARM64

----------------------------------------------------------------
Andy Gross (1):
      firmware: qcom: scm: Add function stubs for ARM64

 drivers/firmware/Makefile      |    4 +++
 drivers/firmware/qcom_scm-64.c |   63 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 drivers/firmware/qcom_scm-64.c

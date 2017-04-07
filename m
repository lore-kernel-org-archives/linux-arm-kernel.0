From: andy.gross@linaro.org (Andy Gross)
Date: Thu,  6 Apr 2017 21:48:36 -0500
Subject: [GIT PULL] Qualcomm Driver Updates for v4.12
Message-ID: <1491533316-13528-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.12

for you to fetch changes up to b182cc4d597a6e73ff04ee1b7fb4f1a28f56ae3d:

  firmware: qcom_scm: add two scm calls for iommu secure page table (2017-03-28 16:03:21 -0500)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v4.12

* Add SCM APIs for restore_sec_cfg and iommu secure page table

----------------------------------------------------------------
Rob Clark (1):
      firmware/qcom: add qcom_scm_restore_sec_cfg()

Stanimir Varbanov (1):
      firmware: qcom_scm: add two scm calls for iommu secure page table

 drivers/firmware/qcom_scm-32.c | 18 +++++++++++++
 drivers/firmware/qcom_scm-64.c | 58 ++++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/qcom_scm.c    | 18 +++++++++++++
 drivers/firmware/qcom_scm.h    | 11 ++++++++
 include/linux/qcom_scm.h       |  6 +++++
 5 files changed, 111 insertions(+)

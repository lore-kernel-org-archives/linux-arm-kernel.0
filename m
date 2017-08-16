From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 16 Aug 2017 10:17:24 -0500
Subject: [GIT PULL] Qualcomm Driver updates for 4.14
Message-ID: <1502896644-6993-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.14

for you to fetch changes up to 445c2410a449ae29c0ec0bb9cee8f38078c4a2f1:

  soc: qcom: mdt_loader: Use request_firmware_into_buf() (2017-08-08 17:41:23 -0500)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v4.14

* Minor fixes for SMSM and WCNSS_CTRL
* Move Qcom SoC drivers to submenu
* Fix mdt_loader to use request_firmware_into_buf()

----------------------------------------------------------------
Bjorn Andersson (1):
      soc: qcom: mdt_loader: Use request_firmware_into_buf()

Rob Clark (2):
      soc: qcom: smsm: fix of_node refcnting problem
      soc: qcom: wcnss_ctrl: add missing MODULE_DEVICE_TABLE()

Srinivas Kandagatla (1):
      soc: qcom: bring all qcom drivers into a submenu

 drivers/soc/qcom/Kconfig      | 4 ++++
 drivers/soc/qcom/mdt_loader.c | 5 ++---
 drivers/soc/qcom/smsm.c       | 3 ++-
 drivers/soc/qcom/wcnss_ctrl.c | 1 +
 4 files changed, 9 insertions(+), 4 deletions(-)

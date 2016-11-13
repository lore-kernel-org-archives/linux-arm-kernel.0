From: andy.gross@linaro.org (Andy Gross)
Date: Sun, 13 Nov 2016 00:15:34 -0600
Subject: [GIT PULL] Qualcomm Driver Updates for v4.10
In-Reply-To: <1479017736-13564-1-git-send-email-andy.gross@linaro.org>
References: <1479017736-13564-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1479017736-13564-4-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.10

for you to fetch changes up to bd4760ca03156731674a570e44490986189d8228:

  firmware: qcom: scm: Use devm_reset_controller_register() (2016-11-12 23:24:51 -0600)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v4.10

* Fixup QCOM SCM to use devm_reset_controller_register
* Add QCOM pinctrl to Qualcomm MAINTAINERS entry
* Add PM8994 regulator definitions
* Add stub for WCNSS_CTRL API

----------------------------------------------------------------
Bjorn Andersson (1):
      soc: qcom: wcnss_ctrl: Stub wcnss_ctrl API

Michael Scott (1):
      MAINTAINERS: add drivers/pinctrl/qcom to ARM/QUALCOMM SUPPORT

Srinivas Kandagatla (1):
      pinctrl: pm8994: add pad voltage regulator defines

Wei Yongjun (1):
      firmware: qcom: scm: Use devm_reset_controller_register()

 MAINTAINERS                                  |  1 +
 drivers/firmware/qcom_scm.c                  |  4 +++-
 include/dt-bindings/pinctrl/qcom,pmic-gpio.h |  4 ++++
 include/dt-bindings/pinctrl/qcom,pmic-mpp.h  |  6 ++++++
 include/linux/soc/qcom/wcnss_ctrl.h          | 13 +++++++++++++
 5 files changed, 27 insertions(+), 1 deletion(-)

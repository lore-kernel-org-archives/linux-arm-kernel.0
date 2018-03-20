From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 19 Mar 2018 21:28:00 -0500
Subject: [GIT PULL] Qualcomm Driver updates for 4.17
In-Reply-To: <1521512881-1854-1-git-send-email-andy.gross@linaro.org>
References: <1521512881-1854-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1521512881-1854-3-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.17

for you to fetch changes up to 90c29ed7627b6b4aeb603ee197650173c8434512:

  soc: qcom: wcnss_ctrl: Fix increment in NV upload (2018-03-08 18:40:35 -0600)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v4.17

* Fix NV upload increment in wcnss_ctrl
* Add support in rmtfs-mem driver for assigning memory

----------------------------------------------------------------
Bjorn Andersson (2):
      soc: qcom: rmtfs-mem: Add support for assigning memory to remote
      soc: qcom: wcnss_ctrl: Fix increment in NV upload

 drivers/soc/qcom/Kconfig      |  1 +
 drivers/soc/qcom/rmtfs_mem.c  | 34 ++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/wcnss_ctrl.c |  2 +-
 3 files changed, 36 insertions(+), 1 deletion(-)

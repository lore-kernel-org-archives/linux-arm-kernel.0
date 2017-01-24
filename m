From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 24 Jan 2017 00:48:11 -0600
Subject: [GIT PULL] Qualcomm Defconfig Updates for v4.11
In-Reply-To: <1485240494-8040-1-git-send-email-andy.gross@linaro.org>
References: <1485240494-8040-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1485240494-8040-2-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-defconfig-for-4.11

for you to fetch changes up to e96165a30f0dc2f02f9578a02c8feb9fbb428802:

  ARM: defconfig: qcom: add APQ8060 DragonBoard devices (2017-01-13 12:50:19 -0600)

----------------------------------------------------------------
Qualcomm ARM Based defconfig Updates for v4.11

* Enable APQ8060 Dragonboard related devices
* Enable AHCI, PCIE, USB, thermal sensors, and ATL1C related configs
* Enable RPM/RPM-SMD clocks

----------------------------------------------------------------
Georgi Djakov (1):
      ARM: qcom_defconfig: Enable RPM/RPM-SMD clocks

Linus Walleij (1):
      ARM: defconfig: qcom: add APQ8060 DragonBoard devices

Srinivas Kandagatla (4):
      ARM: qcom_defconfig: add usb related configs
      ARM: qcom_defconfig: add pcie and atl1c ethernet configs
      ARM: qcom_defconfig: add ahci configs
      ARM: qcom_defconfig: enable thermal sensors

 arch/arm/configs/qcom_defconfig | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

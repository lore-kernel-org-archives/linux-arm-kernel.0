From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 23 May 2014 13:42:07 -0500 (CDT)
Subject: [GIT PULL] qcom SoC changes for v3.16
Message-ID: <alpine.DEB.2.00.1405231339340.15680@galak-ubuntu.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-soc-for-3.16

for you to fetch changes up to 87cfb00d666cca3abf36f755279cde1b27b9c377:

   ARM: qcom: Select PINCTRL by default for ARCH_QCOM (2014-05-22 11:50:42 -0500)

----------------------------------------------------------------
Qualcomm ARM Based SoC Updates for v3.16

* Enabling building pinctrl and AMBA bus support
* Clean up debug UART selection

----------------------------------------------------------------
Andy Gross (1):
       ARM: qcom: Select PINCTRL by default for ARCH_QCOM

Ivan T. Ivanov (1):
       ARM: debug: qcom: make UART address selection configuration option

Srinivas Kandagatla (1):
       ARM: qcom: Enable ARM_AMBA option for Qualcomm SOCs.

  arch/arm/Kconfig.debug       | 81 ++++++++++++++++++--------------------------
  arch/arm/include/debug/msm.S | 46 +++----------------------
  arch/arm/mach-msm/Kconfig    |  3 --
  arch/arm/mach-qcom/Kconfig   |  2 ++
  4 files changed, 40 insertions(+), 92 deletions(-)

--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

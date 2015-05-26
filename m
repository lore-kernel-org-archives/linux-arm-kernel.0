From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 26 May 2015 14:17:45 -0500 (CDT)
Subject: [GIT PULL] qcom dt changes for 4.2
Message-ID: <alpine.DEB.2.02.1505261415380.24694@galak-ubuntu.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-dt-for-4.2

for you to fetch changes up to b73b31577f70a1d03aee21d0127da44862b7b08e:

   ARM: dts: qcom: Add msm8660 PMU node (2015-04-27 16:15:28 -0500)

----------------------------------------------------------------
Qualcomm ARM Based Device Tree Updates for v4.2

* Added support for regulators, USB Host & OTG, SATA, and i2c
   controllers on APQ8064 based platforms
* Added PM8841/PM8941/PMA8084 device nodes
* Added PMU support on MSM8660

----------------------------------------------------------------
Ivan T. Ivanov (3):
       ARM: dts: qcom: Add PM8841 functions device nodes
       ARM: dts: qcom: Add PM8941 functions device nodes
       ARM: dts: qcom: Add PMA8084 functions device nodes

Nicolas Dechesne (2):
       ARM: dts: qcom: apq8064 - Add usb host support to CM QS-600
       ARM: dts: qcom: apq8064 - Add USB OTG support for CM QS-600

Pramod Gurav (1):
       ARM: dts: qcom: apq8064-ifc6410 - Add DT alias for serial port

Srinivas Kandagatla (8):
       ARM: dts: qcom: apq8064 - add RPM regulators support
       ARM: dts: qcom: apq8064-ifc6410 - Add basic regulators
       ARM: dts: qcom: apq8064 - Add usb host support.
       ARM: dts: qcom: apq8064 - Add USB OTG support
       ARM: dts: qcom: apq8064 - Add SATA controller support
       ARM: dts: qcom: apq8064-cm-qs600 - Add basic regulators
       ARM: dts: qcom: apq8064 - Move i2c1 pinctrl to apq8064.dtsi
       ARM: dts: qcom: apq8064 - add i2c3 node for panel.

Stephen Boyd (1):
       ARM: dts: qcom: Add msm8660 PMU node

  arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 100 ++++++++++++++++
  arch/arm/boot/dts/qcom-apq8064-ifc6410.dts  | 136 +++++++++++++++++++--
  arch/arm/boot/dts/qcom-apq8064.dtsi         | 175 +++++++++++++++++++++++++++-
  arch/arm/boot/dts/qcom-msm8660.dtsi         |   5 +
  arch/arm/boot/dts/qcom-pm8841.dtsi          |  18 +++
  arch/arm/boot/dts/qcom-pm8941.dtsi          | 133 ++++++++++++++++++++-
  arch/arm/boot/dts/qcom-pma8084.dtsi         |  92 +++++++++++++++
  7 files changed, 649 insertions(+), 10 deletions(-)

--
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

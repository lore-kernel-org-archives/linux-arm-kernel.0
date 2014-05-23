From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 23 May 2014 13:37:58 -0500 (CDT)
Subject: [GIT PULL] qcom DT changes for v3.15
Message-ID: <alpine.DEB.2.00.1405231337490.15680@galak-ubuntu.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-dt-for-3.16

for you to fetch changes up to 08f9234ad6b0b8bc51046346eabf5b92e631e62a:

   soc: qcom: Add device tree binding for GSBI (2014-05-23 11:38:53 -0500)

----------------------------------------------------------------
Qualcomm ARM Based Device Tree Updates for v3.16

* Added device tree nodes for pinctrl and SDHC for msm8974 SoC/DB8074 board
* Added binding spec for GSBI configuration node

----------------------------------------------------------------
Andy Gross (1):
       soc: qcom: Add device tree binding for GSBI

Georgi Djakov (1):
       ARM: dts: msm: Add SDHC controller nodes for MSM8974 and DB8074 board

Ivan T. Ivanov (1):
       ARM: dts: MSM8974: Add pinctrl node

  .../devicetree/bindings/soc/qcom/qcom,gsbi.txt     | 78 ++++++++++++++++++++++
  arch/arm/boot/dts/qcom-apq8074-dragonboard.dts     | 13 ++++
  arch/arm/boot/dts/qcom-msm8974.dtsi                | 51 ++++++++++++++
  include/dt-bindings/soc/qcom,gsbi.h                | 26 ++++++++
  4 files changed, 168 insertions(+)
  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.txt
  create mode 100644 include/dt-bindings/soc/qcom,gsbi.h

--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

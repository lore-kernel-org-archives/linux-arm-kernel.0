From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Tue,  2 Sep 2014 18:40:40 +0300
Subject: [PATCH v2 0/3] ARM: dts: qcom: Add initial IFC6540 board support
Message-ID: <1409672443-4289-1-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic support for the IFC6540 single-board computer boards, that are
based on the APQ8084 SoC. The first patch adds the initial device tree.
The second enables the serial console. The third adds the SDHC nodes and
enables the eMMC.

Should go through the qcom/arm-soc tree.

Changes since v1:
 - This time add linux-arm-msm list to the CC.
 - Include a third patch for enabling the eMMC.

Georgi Djakov (3):
  ARM: dts: qcom: Add initial IFC6540 board device tree
  ARM: dts: qcom: Enable serial port on IFC6540 boards
  ARM: dts: qcom: Add SDHC nodes for APQ8084 platform

 arch/arm/boot/dts/Makefile                 |    1 +
 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts |   23 +++++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8084.dtsi        |   23 +++++++++++++++++++++++
 3 files changed, 47 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts

-- 
1.7.9.5

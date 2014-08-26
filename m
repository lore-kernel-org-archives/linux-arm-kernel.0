From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Tue, 26 Aug 2014 18:39:36 +0300
Subject: [PATCH v1 0/2] ARM: dts: qcom: Add initial IFC6540 board support
Message-ID: <1409067578-30272-1-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic support for the IFC6540 single-board computer boards, that are
based on the APQ8084 SoC. The first patch adds the initial device tree
and the second enables the serial console.

Should go through the qcom/arm-soc tree.

Georgi Djakov (2):
  ARM: dts: qcom: Add initial IFC6540 board device tree
  ARM: dts: qcom: Enable serial port on IFC6540 boards

 arch/arm/boot/dts/Makefile                 |    1 +
 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts |   12 ++++++++++++
 2 files changed, 13 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts

-- 
1.7.9.5

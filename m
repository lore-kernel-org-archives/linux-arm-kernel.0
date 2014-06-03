From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Tue,  3 Jun 2014 17:29:39 +0300
Subject: [PATCH v3 0/2] ARM: dts: qcom: Add APQ8084 DT nodes for GCC and UART
Message-ID: <1401805781-26637-1-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds DT nodes for the APQ8084 global clock controller 
and serial port.

Should go through qcom/arm-soc tree.

Changes from v2:
 - Split the DT patches into separate patchset. (suggested by Kumar Gala)

Changes from v1:
 - Moved APQ8084 clocks into a separate file and under separate Kconfig
   entry. Dropped the override function patch from v1.
 - Added the missing information about resets (suggested by Kumar Gala).
 - Made the UART DT node "disabled" in dtsi and "okay" in dts (suggested
   by Kumar Gala)


Georgi Djakov (2):
  ARM: dts: qcom: Add APQ8084 Global Clock Controller DT node
  ARM: dts: qcom: Add APQ8084 serial port DT node

 arch/arm/boot/dts/qcom-apq8084-mtp.dts |    6 ++++++
 arch/arm/boot/dts/qcom-apq8084.dtsi    |   18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

-- 
1.7.9.5

From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 27 Sep 2014 10:28:46 +0530
Subject: [PATCH 0/2] Exynos3250: add DT node and clock for UART2 and UART3
Message-ID: <1411793928-32692-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds device tree node and missing clock support of UART2
and UART3 for Exynos3250. DT patch is dependent on clock patch.

Pankaj Dubey (2):
  clk: samsung: exynos3250: add uart2/3 related clocks
  arm: dts: exynos3250: add device node support for serial2 and serial3

 arch/arm/boot/dts/exynos3250-pinctrl.dtsi |   21 +++++++++++++++++++++
 arch/arm/boot/dts/exynos3250.dtsi         |   24 ++++++++++++++++++++++++
 drivers/clk/samsung/clk-exynos3250.c      |   11 +++++++++++
 include/dt-bindings/clock/exynos3250.h    |   10 +++++++++-
 4 files changed, 65 insertions(+), 1 deletion(-)

-- 
1.7.9.5

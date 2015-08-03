From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Mon,  3 Aug 2015 21:37:25 +0900
Subject: [PATCH 0/2] mfd/EXYNOS: Properly shutdown Odroid XU3
Message-ID: <1438605447-6836-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This fixes shutdown of Odroid XU3 family. More details in patch 1.

Patches are independent, please pick up freely.

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  mfd: s2mps11: Add manual shutdown method for Odroid XU3
  ARM: dts: Fix power off method on exynos5422-odroidxu3

 Documentation/devicetree/bindings/mfd/s2mps11.txt  |  4 +++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
 drivers/mfd/sec-core.c                             | 31 ++++++++++++++++++++++
 include/linux/mfd/samsung/core.h                   |  2 ++
 include/linux/mfd/samsung/s2mps11.h                |  1 +
 5 files changed, 39 insertions(+)

-- 
2.1.4

From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Tue, 11 Aug 2015 19:09:03 +0900
Subject: [PATCH v2 0/3] mfd: EXYNOS: Properly shutdown Odroid XU3
Message-ID: <1439287746-14034-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changelog put in each patch message.

This fixes shutdown of Odroid XU3 family. More details in patch 2.

Patches are independent, please pick up freely.

Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  mfd: documentation: dt: Document grounded ACOKB pin on S2MPS11
  mfd: s2mps11: Add manual shutdown method for Odroid XU3
  ARM: dts: Fix power off method on exynos5422-odroidxu3

 Documentation/devicetree/bindings/mfd/s2mps11.txt  |  4 +++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
 drivers/mfd/sec-core.c                             | 30 ++++++++++++++++++++++
 include/linux/mfd/samsung/core.h                   |  2 ++
 include/linux/mfd/samsung/s2mps11.h                |  1 +
 5 files changed, 38 insertions(+)

-- 
2.1.4

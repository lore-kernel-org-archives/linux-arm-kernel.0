From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 06:37:06 +0900
Subject: [PATCH v2] ARM: EXYNOS: add support GPIO for EXYNOS5250
Message-ID: <1329341829-14403-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support GPIOlib for EXYNOS5250 and is including
use ioremap() for EXYNOS4210 and GPIO5250 GPIOlib instead of
static mapping.

Changes since v1:
- use ioremap() for base address of gpio instead of static
  mapping for EXYNOS4210 and EXYNOS5250

NOTE: this patches depend on EXYNOS5250 supporting patches

[PATCH v2 1/3] ARM: EXYNOS: add support GPIO for EXYNOS5250
[PATCH v2 2/3] gpio/samsung: add support GPIOlib for EXYNOS5250
[PATCH v2 3/3] gpio/samsung: use ioremap() for EXYNOS4 GPIOlib

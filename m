From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 16 Jul 2011 15:55:34 +0900
Subject: [PATCH 0/7] ARM: EXYNOS4: Adds External GIC
In-Reply-To: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
References: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
Message-ID: <037601cc4385$604ca990$20e5fcb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changhwan Youn wrote:
> 
> This patch adds implementation External GIC on EXYNOS4 SoC.
> 
> Note: need to update timer codes for supporting old type of
> EXYNOS4 SoCs.
> 
> [PATCH 1/7] ARM: EXYNOS4: Add external GIC io memory mapping
> [PATCH 2/7] ARM: EXYNOS4: modify interrupt mappings for external GIC
> [PATCH 3/7] ARM: EXYNOS4: set the affinity of mct1 interrupt using
IRQ_MCT_L1
> [PATCH 4/7] ARM: GIC: move gic_chip_data structure declaration to header
> [PATCH 5/7] ARM: EXYNOS4: Add support external GIC
> [PATCH 6/7] ARM: EXYNOS4: Remove clock event timers using ARM private
timers
> [PATCH 7/7] ARM: EXYNOS4: Add chained enrty/exit function to uart
interrupt
> handler

OK, applied.
Thanks.

As a note, this is needed for to support upcoming other EXYNOS4 SoCs with
current exynos4 mainline.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

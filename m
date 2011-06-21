From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 21 Jun 2011 09:01:01 +0900
Subject: [PATCH 0/7] ARM: EXYNOS4: Adds External GIC
In-Reply-To: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
References: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
Message-ID: <BANLkTiksfkfzs1nQS0C5uE=pizoOWcnPzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

There are some boards which use the EVT0 chip. some SMDKV310 and
Universal-C210.
With this changes, it can't use these boards.

Do you want to remove EVT0 based boards?

Thank you,
Kyungmin Park

On Mon, Jun 20, 2011 at 4:34 PM, Changhwan Youn <chaos.youn@samsung.com> wrote:
> This patch adds implementation External GIC on EXYNOS4 SoC.
>
> Note: need to update timer codes for supporting old type of
> EXYNOS4 SoCs.
>
> [PATCH 1/7] ARM: EXYNOS4: Add external GIC io memory mapping
> [PATCH 2/7] ARM: EXYNOS4: modify interrupt mappings for external GIC
> [PATCH 3/7] ARM: EXYNOS4: set the affinity of mct1 interrupt using IRQ_MCT_L1
> [PATCH 4/7] ARM: GIC: move gic_chip_data structure declaration to header
> [PATCH 5/7] ARM: EXYNOS4: Add support external GIC
> [PATCH 6/7] ARM: EXYNOS4: Remove clock event timers using ARM private timers
> [PATCH 7/7] ARM: EXYNOS4: Add chained enrty/exit function to uart interrupt handler
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>

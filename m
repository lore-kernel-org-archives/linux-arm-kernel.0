From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 18 Jul 2011 17:00:56 +0900
Subject: [PATCH V2 0/8] ARM: EXYNOS4: Update PM
In-Reply-To: <1309485457-13305-1-git-send-email-kgene.kim@samsung.com>
References: <1309485457-13305-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <04a701cc4520$d3b02c30$7b108490$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> This patch updates EXYNOS4 PM based on Russell's suspend consolidation
> patches.
> 
> NOTE: Depends on external GIC patches which are from Changhwan Youn.
> 
> Changes since V1:
> - address comments from Russell King
> 
> [PATCH V2 1/8] ARM: EXYNOS4: Support system level power down configuration
> [PATCH V2 2/8] ARM: EXYNOS4: Remove PMU configuration for S2RAM
> [PATCH V2 3/8] ARM: EXYNOS4: Add support PM with external GIC
> [PATCH V2 4/8] ARM: SAMSUNG: Add support for failure of sleep mode
> [PATCH V2 5/8] ARM: EXYNOS4: Support early wakeup entering sleep mode
> [PATCH V2 6/8] ARM: EXYNOS4: Move S5P_CENTRAL_SEQ_CONFIGURATION
> setting for PM
> [PATCH V2 7/8] ARM: EXYNOS4: Add save/restore for other ARM registers
> [PATCH V2 8/8] ARM: EXYNOS4: Add save/restore function for PLL

Hi Russell and all,

I'm going to merge this whole series in my for-next except 3rd and 4th
patches late today.
The 3rd patch can be replaced with Colin's regarding suspend-to-ram GIC and
the 4th patch is not needed now because it's ok with Russell's suspend
patch.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

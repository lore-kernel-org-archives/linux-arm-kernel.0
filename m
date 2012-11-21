From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 22 Nov 2012 00:50:31 +0900
Subject: [PATCH v3 02/12] ARM: EXYNOS: Add clk_ops for gating clocks of
 System MMU
In-Reply-To: <002801cdc7a5$8535f6d0$8fa1e470$%cho@samsung.com>
References: <002801cdc7a5$8535f6d0$8fa1e470$%cho@samsung.com>
Message-ID: <50ACF847.3070709@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/12 14:03, Cho KyongHo wrote:
> Touching some System MMU needs its master devices' clock to be enabled
> before. This commit adds clk_ops.set_parent of gating clocks of System
> MMU to ensure gating clocks of System MMU's mater devices are enabled
> when enabling gating clocks of System MMU.
>
> Change-Id: Icd58b12f599e92692c032516331a444f4703ba6b

Same here, we don't need this :-)

> Signed-off-by: KyongHo Cho<pullip.cho@samsung.com>
> ---
>   arch/arm/mach-exynos/clock-exynos5.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>

Looks good to me, and I think, this can be applied independently from 
this series. Will apply with removing 'Change-Id'.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

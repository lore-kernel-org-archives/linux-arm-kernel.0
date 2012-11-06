From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 06 Nov 2012 19:52:16 +0900
Subject: [PATCH] ARM: dts: exynos4: Add support for Exynos4x12 SoCs
In-Reply-To: <1351089359-7318-1-git-send-email-t.figa@samsung.com>
References: <1351089359-7318-1-git-send-email-t.figa@samsung.com>
Message-ID: <0be601cdbc0c$c97a7e50$5c6f7af0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> This patch adds device tree sources for Exynos4x12 SoC series (currently
> Exynos4212 and Exynos4412) and enables mach-exynos4-dt to support these
> SoCs.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4212.dtsi      | 28 ++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos4412.dtsi      | 28 ++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos4x12.dtsi      | 31
> +++++++++++++++++++++++++++++++
>  arch/arm/mach-exynos/mach-exynos4-dt.c |  2 ++
>  4 files changed, 89 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos4212.dtsi
>  create mode 100644 arch/arm/boot/dts/exynos4412.dtsi
>  create mode 100644 arch/arm/boot/dts/exynos4x12.dtsi
> 

Looks good to me, applied.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

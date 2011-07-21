From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 21 Jul 2011 11:37:54 +0900
Subject: [PATCH] ARM: EXYNOS4: Add more register addresses of CMU.
In-Reply-To: <1311214291-32151-1-git-send-email-myungjoo.ham@samsung.com>
References: <000501cc470b$34a32060$9de96120$%kim@samsung.com>
	<1311214291-32151-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <003901cc474f$377625a0$a66270e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> These registers are crucial for PM to work properly.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos4/include/mach/regs-clock.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/include/mach/regs-clock.h
b/arch/arm/mach-
> exynos4/include/mach/regs-clock.h
> index 64bdd24..d493fdb 100644
> --- a/arch/arm/mach-exynos4/include/mach/regs-clock.h
> +++ b/arch/arm/mach-exynos4/include/mach/regs-clock.h
> @@ -36,7 +36,9 @@
>  #define S5P_CLKSRC_TOP0			S5P_CLKREG(0x0C210)
>  #define S5P_CLKSRC_TOP1			S5P_CLKREG(0x0C214)
>  #define S5P_CLKSRC_CAM			S5P_CLKREG(0x0C220)
> +#define S5P_CLKSRC_TV			S5P_CLKREG(0x0C224)
>  #define S5P_CLKSRC_MFC			S5P_CLKREG(0x0C228)
> +#define S5P_CLKSRC_G3D			S5P_CLKREG(0x0C22C)
>  #define S5P_CLKSRC_IMAGE		S5P_CLKREG(0x0C230)
>  #define S5P_CLKSRC_LCD0			S5P_CLKREG(0x0C234)
>  #define S5P_CLKSRC_LCD1			S5P_CLKREG(0x0C238)
> @@ -64,6 +66,7 @@
>  #define S5P_CLKDIV_PERIL3		S5P_CLKREG(0x0C55C)
>  #define S5P_CLKDIV_PERIL4		S5P_CLKREG(0x0C560)
>  #define S5P_CLKDIV_PERIL5		S5P_CLKREG(0x0C564)
> +#define S5P_CLKDIV2_RATIO		S5P_CLKREG(0x0C580)
> 
>  #define S5P_CLKSRC_MASK_TOP		S5P_CLKREG(0x0C310)
>  #define S5P_CLKSRC_MASK_CAM		S5P_CLKREG(0x0C320)
> --
> 1.7.4.1

Thanks for your updating.

Applied with your 'ARM: EXYNOS4: Add more registers to be saved and restored
for PM'.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

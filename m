From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 7 Sep 2010 00:58:04 +0200
Subject: [PATCH 12/74] ST SPEAr: Correcting SOC Config base address for
	spear320
In-Reply-To: <08862b0d4eeed76cbd151741a1582da7855ca452.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<08862b0d4eeed76cbd151741a1582da7855ca452.1283161023.git.viresh.kumar@st.com>
Message-ID: <20100906225804.GE8153@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	not relased to this patch series

Best Regards,
J.
On 16:08 Mon 30 Aug     , Viresh KUMAR wrote:
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  arch/arm/mach-spear3xx/include/mach/spear320.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-spear3xx/include/mach/spear320.h b/arch/arm/mach-spear3xx/include/mach/spear320.h
> index cacf17a..53677e4 100644
> --- a/arch/arm/mach-spear3xx/include/mach/spear320.h
> +++ b/arch/arm/mach-spear3xx/include/mach/spear320.h
> @@ -62,7 +62,7 @@
>  #define SPEAR320_SMII1_BASE		0xAB000000
>  #define SPEAR320_SMII1_SIZE		0x01000000
>  
> -#define SPEAR320_SOC_CONFIG_BASE	0xB4000000
> +#define SPEAR320_SOC_CONFIG_BASE	0xB3000000
>  #define SPEAR320_SOC_CONFIG_SIZE	0x00000070
>  /* Interrupt registers offsets and masks */
>  #define INT_STS_MASK_REG		0x04
> -- 
> 1.7.2.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

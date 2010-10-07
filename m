From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 07 Oct 2010 10:59:03 +0900
Subject: [PATCH 6/7] ARM: S5PC210: Define the more I2C{3, 4, 5, 6,
	7} address & interrupt
In-Reply-To: <20100930044853.GA16918@july>
References: <20100930044853.GA16918@july>
Message-ID: <004e01cb65c3$3c1469f0$b43d3dd0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> S5PC210 supports total 8 (+ 1 dedicated for HDMI) I2C devices.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv310/include/mach/irqs.h |    5 +++++
>  arch/arm/mach-s5pv310/include/mach/map.h  |    5 +++++
>  2 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-
> s5pv310/include/mach/irqs.h
> index aa17ec7..67abe1e 100644
> --- a/arch/arm/mach-s5pv310/include/mach/irqs.h
> +++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
> @@ -72,6 +72,11 @@
>  #define IRQ_IIC			COMBINER_IRQ(27, 0)
>  #define IRQ_IIC1		COMBINER_IRQ(27, 1)
>  #define IRQ_IIC2		COMBINER_IRQ(27, 2)
> +#define IRQ_I2C3		COMBINER_IRQ(27, 3)
> +#define IRQ_I2C4		COMBINER_IRQ(27, 4)
> +#define IRQ_I2C5		COMBINER_IRQ(27, 5)
> +#define IRQ_I2C6		COMBINER_IRQ(27, 6)
> +#define IRQ_I2C7		COMBINER_IRQ(27, 7)
> 
>  #define IRQ_HSMMC0		COMBINER_IRQ(29, 0)
>  #define IRQ_HSMMC1		COMBINER_IRQ(29, 1)
> diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-
> s5pv310/include/mach/map.h
> index 118ad48..8d34d96 100644
> --- a/arch/arm/mach-s5pv310/include/mach/map.h
> +++ b/arch/arm/mach-s5pv310/include/mach/map.h
> @@ -86,6 +86,11 @@
>  #define S3C_PA_IIC			S5PV310_PA_I2C(0)
>  #define S3C_PA_IIC1			S5PV310_PA_I2C(1)
>  #define S3C_PA_IIC2			S5PV310_PA_I2C(2)
> +#define S3C_PA_I2C3			S5PV310_PA_I2C(3)
> +#define S3C_PA_I2C4			S5PV310_PA_I2C(4)
> +#define S3C_PA_I2C5			S5PV310_PA_I2C(5)
> +#define S3C_PA_I2C6			S5PV310_PA_I2C(6)
> +#define S3C_PA_I2C7			S5PV310_PA_I2C(7)
>  #define S3C_PA_RTC			S5PV310_PA_RTC
>  #define S3C_PA_WDT			S5PV310_PA_WATCHDOG
> 
> --

Hi,

To keep the same format is helpful to understand codes like IRQ_IICX.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

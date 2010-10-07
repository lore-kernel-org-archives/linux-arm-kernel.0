From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 07 Oct 2010 10:35:22 +0900
Subject: [PATCH 2/7] ARM: S5PC110: Fix wrong interrupt I2C2 number
In-Reply-To: <20100930044827.GA16901@july>
References: <20100930044827.GA16901@july>
Message-ID: <004401cb65bf$ec00b7a0$c40226e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> It's I2C2 interrupt number instead of CAN0.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/include/mach/irqs.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-
> s5pv210/include/mach/irqs.h
> index cdb8ae4..5ab1833 100644
> --- a/arch/arm/mach-s5pv210/include/mach/irqs.h
> +++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
> @@ -55,8 +55,8 @@
>  #define IRQ_SPI1		S5P_IRQ_VIC1(16)
>  #define IRQ_SPI2		S5P_IRQ_VIC1(17)
>  #define IRQ_IRDA		S5P_IRQ_VIC1(18)
> -#define IRQ_CAN0		S5P_IRQ_VIC1(19)
> -#define IRQ_CAN1		S5P_IRQ_VIC1(20)
> +#define IRQ_IIC2		S5P_IRQ_VIC1(19)
> +#define IRQ_I2C_HDMI_PHY	S5P_IRQ_VIC1(20)
>  #define IRQ_HSIRX		S5P_IRQ_VIC1(21)
>  #define IRQ_HSITX		S5P_IRQ_VIC1(22)
>  #define IRQ_UHOST		S5P_IRQ_VIC1(23)
> --

Please refer to my other comments.

Hmm...I think, no need to change to IRQ_I2C_HDMI_PHY...in here.
If required, we can do it later...and how about IRQ_IIC_HDMI_PHY like other
IRQ_IIC?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Jul 2010 09:51:55 +0900
Subject: [PATCH 4/6] S5PV310: Define OneNAND interrupt number
In-Reply-To: <20100728101206.GA21345@july>
References: <20100728101206.GA21345@july>
Message-ID: <007301cb2eb8$4173f650$c45be2f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Define OneNAND interrupt for s5pv310
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv310/include/mach/irqs.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-
> s5pv310/include/mach/irqs.h
> index 56885ca..f7fb2b8 100644
> --- a/arch/arm/mach-s5pv310/include/mach/irqs.h
> +++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
> @@ -66,6 +66,8 @@
> 
>  #define IRQ_IIC			COMBINER_IRQ(27, 0)
> 
> +#define IRQ_ONENAND_AUDI	COMBINER_IRQ(34, 0)
> +

Hmm...your previous #3 patch needs this :-(

Please reverse the order(sequence) of 3rd and 4th...or make into one

>  /* Set the default NR_IRQS */
>  #define NR_IRQS
> 	COMBINER_IRQ(MAX_COMBINER_NR, 0)
> 
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 14 Oct 2010 10:56:39 +0900
Subject: [PATCH] ARM: S5PV310: Update MAX_COMBINER_NR
In-Reply-To: <1286867763-21515-1-git-send-email-sbkim73@samsung.com>
References: <1286867763-21515-1-git-send-email-sbkim73@samsung.com>
Message-ID: <003c01cb6b43$0bf55740$23e005c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sangbeom Kim wrote:
> 
> From: Jongpill Lee <boyko.lee@samsung.com>
> 
> This patch updates MAX_COMBINER_NR from 39 to 40 because
> S5PV310 need 39th combiner for including EINT16_31.
> 
> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> ---
>  arch/arm/mach-s5pv310/include/mach/irqs.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-
> s5pv310/include/mach/irqs.h
> index b2acc62..f301af7 100644
> --- a/arch/arm/mach-s5pv310/include/mach/irqs.h
> +++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
> @@ -89,6 +89,6 @@
> 
>  #define NR_IRQS
> 	COMBINER_IRQ(MAX_COMBINER_NR, 0)
> 
> -#define MAX_COMBINER_NR		39
> +#define MAX_COMBINER_NR		40
> 
>  #endif /* __ASM_ARCH_IRQS_H */
> --

Ok...will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

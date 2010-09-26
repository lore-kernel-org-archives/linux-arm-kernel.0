From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 26 Sep 2010 20:42:06 +0800
Subject: [PATCH] [ARM] pxa/cm-x2xx: remove duplicate call to
	pxa27x_init_irq
In-Reply-To: <1285504669-24341-1-git-send-email-mike@compulab.co.il>
References: <1285504669-24341-1-git-send-email-mike@compulab.co.il>
Message-ID: <AANLkTi=vyUxscy=8Xc2Nr=C2KLYSrqWgujsemVS+eBAc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 26, 2010 at 8:37 PM, Mike Rapoport <mike@compulab.co.il> wrote:
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>

Applied to 'fix'.

> ---
> ?arch/arm/mach-pxa/cm-x2xx.c | ? ?2 --
> ?1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
> index bff6e78..ec12a48 100644
> --- a/arch/arm/mach-pxa/cm-x2xx.c
> +++ b/arch/arm/mach-pxa/cm-x2xx.c
> @@ -473,8 +473,6 @@ static void __init cmx2xx_init(void)
>
> ?static void __init cmx2xx_init_irq(void)
> ?{
> - ? ? ? pxa27x_init_irq();
> -
> ? ? ? ?if (cpu_is_pxa25x()) {
> ? ? ? ? ? ? ? ?pxa25x_init_irq();
> ? ? ? ? ? ? ? ?cmx2xx_pci_init_irq(CMX255_GPIO_IT8152_IRQ);
> --
> 1.6.4.4
>
>

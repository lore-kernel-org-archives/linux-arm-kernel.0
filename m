From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 8 Sep 2011 20:28:40 -0700
Subject: [PATCH 4/4] ARM: pxa: update gpio number to 192
In-Reply-To: <1315541894-19504-4-git-send-email-chao.xie@marvell.com>
References: <1315541894-19504-1-git-send-email-chao.xie@marvell.com>
	<1315541894-19504-4-git-send-email-chao.xie@marvell.com>
Message-ID: <CAMPhdO9PfUd4xjeiRDVA+NkL+ATxN95wn1Ynx8ACXgr0QzW4oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2011 at 9:18 PM, Chao Xie <chao.xie@marvell.com> wrote:
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>
> 192 GPIO pins are supported in pxa95x.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Signed-off-by: Chao Xie <chao.xie@marvell.com>

OK.

> ---
> ?arch/arm/mach-pxa/pxa95x.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/pxa95x.c b/arch/arm/mach-pxa/pxa95x.c
> index 0ee166b..83ecc41 100644
> --- a/arch/arm/mach-pxa/pxa95x.c
> +++ b/arch/arm/mach-pxa/pxa95x.c
> @@ -236,7 +236,7 @@ static struct clk_lookup pxa95x_clkregs[] = {
> ?void __init pxa95x_init_irq(void)
> ?{
> ? ? ? ?pxa_init_irq(96, NULL);
> - ? ? ? pxa_init_gpio(IRQ_GPIO_2_x, 2, 127, NULL);
> + ? ? ? pxa_init_gpio(IRQ_GPIO_2_x, 2, 191, NULL);
> ?}
>
> ?/*
> --
> 1.7.0.4
>
>

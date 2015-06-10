From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 10 Jun 2015 12:29:42 +0200
Subject: [RFT v2 06/48] pinctrl: Use irq_desc_get_xxx() to avoid redundant
 lookup of irq_desc
In-Reply-To: <1433391238-19471-7-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
 <1433391238-19471-7-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <CABuKBeLs21NZ_uTUJ=P6TwX-jAiCaJO--ZnV7O2MZy-TfV6sNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-04 6:13 GMT+02:00 Jiang Liu <jiang.liu@linux.intel.com>:
> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
> already have a pointer to corresponding irq_desc.
>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
[...]
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    4 ++--

For the changes in pinctrl-mtk-common.c:

Acked-by: Matthias Brugger <matthias.brugger@gmail.com>

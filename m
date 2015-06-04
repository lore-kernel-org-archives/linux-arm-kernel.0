From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 4 Jun 2015 08:20:12 +0200
Subject: [RFT v2 05/48] gpio: Use irq_desc_get_xxx() to avoid redundant
 lookup of irq_desc
In-Reply-To: <1433391238-19471-6-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
 <1433391238-19471-6-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <CABxcv==Gg7GOzyo5kAEC5ezQpsTMPo=Bi0H4rfRUY5iQJ4oSTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jiang,

On Thu, Jun 4, 2015 at 6:13 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
> already have a pointer to corresponding irq_desc.
>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpio/gpio-bcm-kona.c   |    2 +-
>  drivers/gpio/gpio-dwapb.c      |    2 +-
>  drivers/gpio/gpio-mvebu.c      |    2 +-
>  drivers/gpio/gpio-mxc.c        |    6 +++---
>  drivers/gpio/gpio-mxs.c        |    2 +-
>  drivers/gpio/gpio-omap.c       |    2 +-

For gpio-omap:

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

Best regards,
Javier

From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 9 May 2013 14:01:00 +0100
Subject: [PATCH 28/63] ARM: ux500: Stop passing UART's platform data for
 Device Tree boots
In-Reply-To: <CACRpkdYCABo0AULsiUgwm3g=906iKzp_ZDFKLj=HgDbNK9mNUQ@mail.gmail.com>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-29-git-send-email-lee.jones@linaro.org>
 <CACRpkdYCABo0AULsiUgwm3g=906iKzp_ZDFKLj=HgDbNK9mNUQ@mail.gmail.com>
Message-ID: <20130509130100.GA12156@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 03 May 2013, Linus Walleij wrote:

> On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > It was required to pass DMA channel configuration information to the
> > UART driver before the new DMA API was in place. Now that it is, and
> > is fully compatible with Device Tree we can stop doing that.
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> I can't apply this as it is clearly dependent on a patch to
> drivers/tty/serial/amba-pl011.c that is not yet upstream.

It is now.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

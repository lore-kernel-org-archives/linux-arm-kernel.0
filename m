From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 May 2013 18:29:51 +0200
Subject: [PATCH 01/39] dmaengine: ste_dma40: Separate Logical Global
 Interrupt Mask (GIM) unmasking
In-Reply-To: <1368611522-9984-2-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZJp-WRGNgzwqERVBtb_WxQGybmMjnnLTAoX66qECNh7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> During the initial setup of a logical channel, it is necessary to unmask
> the GIM in order to receive generated terminal count and error interrupts.
> We're separating out this required code so it will be possible to move
> the remaining code in d40_phy_cfg(), which is mostly runtime configuration
> into the runtime_config() routine.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Tentatively applied to my ux500-dma40 branch.

This lacks an ACK from Vinod...

I cannot get any of this stack of patches up to ARM SoC
before I have Vinod's ACK on all hitting drivers/dma/*

Yours,
Linus Walleij

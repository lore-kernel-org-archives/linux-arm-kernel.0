From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 22:23:57 +0200
Subject: [PATCH 19/63] dmaengine: ste_dma40: Separate Logical Global
 Interrupt Mask (GIM) unmasking
In-Reply-To: <1367591569-32197-20-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-20-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZexk6a7yaWEzzOkihcHNGY_UQN3hYiz45LK1cuy0ob=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:

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

These review comments are only partially accounted for:
http://marc.info/?l=linux-kernel&m=136688761708399&w=2

Please supply a short changelog in the next submission
so I know what was changed and why some things were not
changed and if you split out other changes to other patches
etc etc.

Yours,
Linus Walleij

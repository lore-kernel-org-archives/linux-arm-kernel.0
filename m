From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 10:54:12 +0200
Subject: [PATCH 31/39] dmaengine: ste_dma40: Replace ST-E's home-brew DMA
 direction defs with generic ones
In-Reply-To: <1368611522-9984-32-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-32-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZvdT6jb_dRteNnWDtaOY3jZ2DnRjb0SywOYbt7X51ksg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> STEDMA40_*_TO_* direction definitions are identical in all but name to
> the pre-defined generic DMA_*_TO_* ones. Let's make things easy by not
> duplicating such things.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied to my dma40 branch with Vinod's ACK.

Yours,
Linus Walleij

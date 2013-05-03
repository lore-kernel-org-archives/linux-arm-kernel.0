From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 22:17:26 +0200
Subject: [PATCH 18/63] dmaengine: ste_dma40: Remove 'always true' checking
In-Reply-To: <1367591569-32197-19-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-19-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkda2+49CjTOBcnfjp=EXOhOnrLHz4K+yOH-bKp+s7OmpsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Before allocating memory for logical channels, the current driver
> checks to see if there are any. Well as the dma40_memcpy_channels[]
> array is always populated, the check is always true. Best to
> remove the check.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Tentatively applied to my ux500-dma40 branch.

Vinod, can I have your ACK on this patch?

Yours,
Linus Walleij

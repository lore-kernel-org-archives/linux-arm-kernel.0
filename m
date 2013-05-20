From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 May 2013 14:35:01 +0200
Subject: [PATCH 10/63] dmaengine: ste_dma40: Amalgamate DMA source and
 destination channel numbers
In-Reply-To: <1367591569-32197-11-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-11-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdai7y+LBiFyK+b-CvW6p7n+TbC1iX0+XiLyg2V_8rFL+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:31 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Devices which utilise DMA use the same device numbers for transmitting
> and receiving. In this patch we encode the source and destination
> information into one single attribute. We can subsequently exploit the
> direction attribute to see which of the transfer directions are being
> described. This also lessens the burden on platform data.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Still waiting for an ACK from Vinod on this as well.

Vinod?

Yours,
Linus Walleij

From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sat, 15 May 2010 08:22:35 +0900
Subject: [PATCH] DMA: PL330: Add dma api driver
In-Reply-To: <AANLkTilsUyp4a-mnWLAVXXg6iMFwvBg5d58aViX6umSO@mail.gmail.com>
References: <1273641798-26579-1-git-send-email-jassi.brar@samsung.com>
	<AANLkTilsUyp4a-mnWLAVXXg6iMFwvBg5d58aViX6umSO@mail.gmail.com>
Message-ID: <AANLkTikGRf4FYwWee972jn2PPpmSOz4Qwzp5WKyCMJ1I@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 12, 2010 at 5:37 PM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/5/12 Jassi Brar <jassi.brar@samsung.com>:
>
>> Add DMA Engine API driver for the PL330 DMAC.
>> This driver is supposed to be reusable by various
>> platforms that have one or more PL330 DMACs.
>> Atm, DMA_SLAVE and DMA_MEMCPY capabilities have been
>> implemented.
>>
>> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
>
> Reviewed-by: Linus Walleij <linus.walleij@stericsson.com>
>
> Really looking good now!
Thanks.
Now that the core driver has been accepted by Russell,
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6132/1
 this api driver too could be merged by DMA API maintainers?

regards,
jassi

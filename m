From: jassisinghbrar@gmail.com (jassi brar)
Date: Fri, 7 May 2010 21:50:50 +0900
Subject: [PATCH 2/2] DMA: PL330: Add async dma api driver
In-Reply-To: <i2r63386a3d1005070159tf0879839u24c1c1f11466970d@mail.gmail.com>
References: <1273215671-3090-1-git-send-email-jassisinghbrar@gmail.com>
	<i2r63386a3d1005070159tf0879839u24c1c1f11466970d@mail.gmail.com>
Message-ID: <q2p1b68c6791005070550xc0a90815w6ff676c6c32235e1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 7, 2010 at 5:59 PM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/5/7 Jassi Brar <jassisinghbrar@gmail.com>:
>
>> Add ASYNC DMA Engine API driver for the PL330 DMAC.
>> This driver is supposed to be reusable by various
>> platforms that have one or more PL330 DMACs.
>> Atm, DMA_SLAVE and DMA_MEMCPY capabilities have been
>> implemented.
>>
>> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

.....

> If you fix this and test it on async_tx it's:
> Reviewed-by: Linus Walleij <linus.walleij@stericsson.com>
Will do.
Thanks.

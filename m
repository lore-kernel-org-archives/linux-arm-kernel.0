From: v.sitdikov@gmail.com (Valentin Sitdikov)
Date: Wed, 13 Jan 2010 15:15:32 +0300
Subject: Fwd: DesignWare DMA Controller on at91sam9263
In-Reply-To: <719c3e781001130408u1a126c2es7c7b6a047aa8c15b@mail.gmail.com>
References: <719c3e781001130408u1a126c2es7c7b6a047aa8c15b@mail.gmail.com>
Message-ID: <719c3e781001130415l4b8e63cfka43cab73ef0f676e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---------- Forwarded message ----------
From: Valentin Sitdikov <v.sitdikov@gmail.com>
Date: Wed, Jan 13, 2010 at 3:08 PM
Subject: DesignWare DMA Controller on at91sam9263
To: haavard.skinnemoen at atmel.com
Cc: linux-arm-kernel at lists.arm.linux.org.uk


Hello Haavard.

Could you please comment something on my problem?

Currently i am working on getting at91sam9263 dmac working under demaenige
framework.
So I have investigating that it is a kind of copy Synopsys DesignWare DMA
Controller
which is used in AVR32.
But there is at least one difference:
AVR32 BLOCK_TS is 11 bit wide but at91sam9263 BLOCK_TS is 5 bit size
So your driver is working on at91sam9263 taking in to account this
difference.

As you can imagine to have such a small dma transaction is not quite
convenient.
May be you can recommend something to overcome 5 bit restriction?

There is also bit field in config register which is called MAX_ABRST the
meaning of
which is not quite clear. It is 10 bits long,
So why it 10 bits long if BLOCK_TS only 5 bits long?
What real meaning has it ?

Thanks in advance.
Valentin.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100113/89a8febd/attachment-0001.htm>

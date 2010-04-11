From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 11 Apr 2010 16:13:39 +0200
Subject: [PATCH 00/11] ARM: PrimeCell DMA Interface v5
In-Reply-To: <CEE6BB42CAD6E947908279175AF8470A03A50F78@EXDCVYMBSTM006.EQ1STM.local>
References: <1270681920-4461-1-git-send-email-linus.walleij@stericsson.com>
	<v2se9c3a7c21004071645u8180f4d7p3b4b1f96de11303e@mail.gmail.com>
	<CEE6BB42CAD6E947908279175AF8470A03A50F78@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <n2n63386a3d1004110713w74a16713g13f32219b610d3a6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

are you OK with pushing these patches from this series:

patch 01 - <linux/amba/dma.h>
patch 08 - DMA for drivers/serial/amba-pl011.c

through Dan's async_tx / DMAengine tree?

I think those are the ones which need your Acked-by to proceed.

If you have some other idea of how these patches should be twisted
around please let me know!

Yours,
Linus Walleij

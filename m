From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Wed, 11 Aug 2010 13:22:36 +0200
Subject: [PATCH 2/5] drivers/dma: Return -ENOMEM on memory allocation
	failure
In-Reply-To: <Pine.LNX.4.64.1008111210490.8669@ask.diku.dk>
References: <Pine.LNX.4.64.1008111210490.8669@ask.diku.dk>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A0262F4A8EF@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Julia Lawall <julia@diku.dk>
> 
> In this code, 0 is returned on memory allocation failure, even though
> other failures return -ENOMEM or other similar values.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Thanks for fixing this Julia!

Yours,
Linus Walleij

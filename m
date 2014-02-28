From: b32955@freescale.com (Huang Shijie)
Date: Fri, 28 Feb 2014 16:54:34 +0800
Subject: change kmalloc into vmalloc for large memory allocations
In-Reply-To: <35FD53F367049845BC99AC72306C23D102844605F38C@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D102844605F38C@CNBJMBX05.corpusers.net>
Message-ID: <53104ECA.4010702@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2014?02?28? 16:15, Wang, Yalin ??:
> could this module change the memory allocation into vmalloc ?
the buffer allocated by vmalloc can not be used for the DMA.

I think that's why drivers use the kmalloc.

thanks
Huang Shijie

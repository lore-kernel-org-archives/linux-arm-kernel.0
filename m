From: ryan.raasch@gmail.com (Ryan Raasch)
Date: Mon, 14 Dec 2009 14:31:03 +0100
Subject: Disable pxa dma option for smc911x
Message-ID: <4B263E17.2090407@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Because our system, we have had to disable the dma for our chip  :)  We
don't know why yet...

However, when disabling the DMA, there are a couple of cpp errors, which
this patch fixes.

Greetings,
Ryan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fix_smc911x_pxa_dma_disable.patch
Type: text/x-patch
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091214/03d10766/attachment.bin>

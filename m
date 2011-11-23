From: b32955@freescale.com (Huang Shijie)
Date: Wed, 23 Nov 2011 19:04:44 +0800
Subject: [PATCH] IMX/SDMA : save the real count for one DMA transaction.
In-Reply-To: <20111123105821.GC4063@pengutronix.de>
References: <1322039585-7901-1-git-send-email-b32955@freescale.com>
 <20111123105821.GC4063@pengutronix.de>
Message-ID: <4ECCD34C.1090400@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
>> +	/* save the real count we received or transmitted. */
>> +	chan->private = (void *)count;
> And if someone later needs another variable which is private?
>
I ever wanted to add an new parameter `void *` to dma_aync_tx_callback,
but it seemed i have
to change a lot of files.

Do you have any better suggestion?

thanks
Huang Shijie

From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 16 Nov 2016 09:32:52 +0100
Subject: [2/2] dmaengine: at_xdmac: fix spurious flag status for mem2mem
 transfers
In-Reply-To: <7fbfd098-31d8-d184-37a9-8865fdb7fb8d@denx.de>
References: <7fbfd098-31d8-d184-37a9-8865fdb7fb8d@denx.de>
Message-ID: <2633a3a8-3d2f-7f89-e940-a998e82aadce@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/10/2016 ? 23:57, Marek Vasut a ?crit :
> Hi,
> 
> this patch [1] should also CC stable, since it fixes MMC operation in at
> least linux 4.4 .
> 
> Thanks!
> 
> [1] https://patchwork.kernel.org/patch/7681201/

I did that (without putting you in copy: sorry).
https://www.spinics.net/lists/stable/msg151272.html

Thanks a lot for the heads-up Marek!

Best regards,
-- 
Nicolas Ferre

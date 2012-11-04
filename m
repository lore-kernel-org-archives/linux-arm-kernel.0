From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 5 Nov 2012 00:02:35 +0100
Subject: [PATCH] net/at91_ether: fix the use of macb structure
In-Reply-To: <20121103.150414.707741347606909244.davem@davemloft.net>
References: <75eb5df193c504e68ebff7d6a6a88d9a1cc678cb.1351591858.git.nicolas.ferre@atmel.com>
 <1351596628-3405-1-git-send-email-nicolas.ferre@atmel.com>
 <20121103.150414.707741347606909244.davem@davemloft.net>
Message-ID: <5096F40B.60509@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2012 08:04 PM, David Miller :
> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> Date: Tue, 30 Oct 2012 12:30:28 +0100
> 
>> Due to the use of common structure in at91_ether and macb drivers,
>> change the name of DMA descriptor structures in at91_ether as well:
>> dma_desc => macb_dma_desc
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> This does not apply to net-next, respin it if this change is
> still relevant.

This one is not relevant anymore.

Best regards,
-- 
Nicolas Ferre

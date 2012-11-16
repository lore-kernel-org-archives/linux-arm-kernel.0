From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 16 Nov 2012 11:33:51 +0100
Subject: [PATCH 1/5] ARM: AT91SAM9G45: fix crypto peripherals irq issue
 due to sparse irq support.
In-Reply-To: <20121107152729.GE4576@game.jcrosoft.org>
References: <1352219463-30360-1-git-send-email-nicolas@eukrea.com>
 <20121107152729.GE4576@game.jcrosoft.org>
Message-ID: <50A6168F.90105@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2012 04:27 PM, Jean-Christophe PLAGNIOL-VILLARD :
> On 17:31 Tue 06 Nov     , Nicolas Royer wrote:
>> Spare irq support introduced by commit "8fe82a5 ARM: at91: sparse irq support"
>> involves to add the NR_IRQS_LEGACY offset to irq number.
>>
>> Signed-off-by: Nicolas Royer <nicolas@eukrea.com>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Acked-by: Eric B?nard <eric@eukrea.com>
>> Tested-by: Eric B?nard <eric@eukrea.com>
>> Cc: stable at vger.kernel.org # 3.6
> 
> ok will see if we can have it for 3.7

Queued in our at91-fixes pull request for 3.7-final.

Thanks a lot, best regards,
-- 
Nicolas Ferre

From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 27 Nov 2013 10:41:42 +0100
Subject: [PATCH] mmc: atmel-mci: fix timeout errors in SDIO mode when
 using DMA
In-Reply-To: <87zjoqer82.fsf@octavius.laptop.org>
References: <1384959671-5646-1-git-send-email-ludovic.desroches@atmel.com>	<528E29D0.9080507@atmel.com>
 <87zjoqer82.fsf@octavius.laptop.org>
Message-ID: <5295BE56.3060609@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/11/2013 23:24, Chris Ball :
> Hi,
>
> On Thu, Nov 21 2013, Nicolas Ferre wrote:
>> On 20/11/2013 16:01, ludovic.desroches at atmel.com :
>>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>>
>>> With some SDIO devices, timeout errors can happen when reading data. To solve
>>> this issue the DMA transfer has to be activated before sending the command to
>>> the device. This order is incorrect in PDC mode. So we have to take care if we
>>> are using DMA or PDC to know when to send the MMC command.
>>>
>>> Cc: <stable@vger.kernel.org> #3.2+
>>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> Thanks, pushed to mmc-next for 3.14.

Nice, thank you Chris, but what about considering its inclusion in 3.13?

I know that it will anyway hit the 3.13.y stable update but I do think 
that it would be nice to have this fix sooner in official 3.13...

Bye,
-- 
Nicolas Ferre

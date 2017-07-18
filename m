From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Tue, 18 Jul 2017 11:23:43 +0200
Subject: [PATCH 2/3] mfd: syscon: atmel-smc: add helper to retrieve
 register layout
In-Reply-To: <20170718091238.wweaobzccdlgv5dh@dell>
References: <20170711074015.30440-1-ludovic.desroches@microchip.com>
 <20170711074015.30440-3-ludovic.desroches@microchip.com>
 <20170718081508.yo6uld5ip5hr6ipk@dell> <20170718091238.wweaobzccdlgv5dh@dell>
Message-ID: <02a0c390-610c-d38b-e6a3-f04120c6fbb3@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/07/2017 at 11:12, Lee Jones wrote:
> On Tue, 18 Jul 2017, Lee Jones wrote:
> 
>> On Tue, 11 Jul 2017, Ludovic Desroches wrote:
>>
>>> For HSMC controller, the register layout depends on the device i.e. the
>>> offset of setup, pulse, cycle, mode and timings registers is not the
>>> same. An helper is added to provide the correct register layout.
>>>
>>> Fixes: fe9d7cb22ef3 ("mfd: syscon: atmel-smc: Add new helpers to ease
>>> SMC regs manipulation")
>>> Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>>> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
>>> ---
>>>  drivers/memory/atmel-ebi.c               | 13 +++++--
>>>  drivers/mfd/atmel-smc.c                  | 67 +++++++++++++++++++++++++-------
>>>  drivers/mtd/nand/atmel/nand-controller.c | 10 +++--
>>>  include/linux/mfd/syscon/atmel-smc.h     | 32 ++++++++++-----
>>>  4 files changed, 92 insertions(+), 30 deletions(-)
>>
>> Applied, thanks.
> 
> Apologies, it looks like this needs 2 more Acks before I can even
> consider taking it.
> 
> Unapplied.

If mine is missing, here it is:

For the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

And I think that Alexandre seemed okay by discussing the path those
patches should take...


Thanks, bye,
-- 
Nicolas Ferre

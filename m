From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 28 Feb 2014 10:25:15 -0500
Subject: [PATCH] dma: of: Move the functions under CONFIG_OF_DMA instead
 of CONFIG_OF
In-Reply-To: <5164707.sdmWv7EuCX@wuerfel>
References: <1393546850-13907-1-git-send-email-santosh.shilimkar@ti.com>
 <5615884.O4eVkOuQqe@wuerfel> <5310A52E.90908@ti.com>
 <5164707.sdmWv7EuCX@wuerfel>
Message-ID: <5310AA5B.3000309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 February 2014 10:21 AM, Arnd Bergmann wrote:
> On Friday 28 February 2014 10:03:10 Santosh Shilimkar wrote:
>>> As of 5fa422c922c25 "dmaengine: move drivers/of/dma.c -> drivers/dma/of-dma.c"
>>>
>>> which seems to solve the problem already.
>>>
>>>> I am not sure but we added couple of functions for dma-ranges
>>>> and dma-coherent which gets called from generic code.
>>>
>>> These functions have nothing to do with the dmaengine code though,
>>> they should be in a different file.
>>>
>> Any suggestion on different file ?
>  
> drivers/of/platform.c would be my first choice. Possibly a new
> drivers/of/dma-mapping.c.
> 
'drivers/of/platform.c' sounds good.
Regards,
Santosh

From: zonque@gmail.com (Daniel Mack)
Date: Thu, 05 Jul 2012 18:05:08 +0200
Subject: [alsa-devel] DT support for Davinci ASoC platform
In-Reply-To: <201207051536.45920.arnd@arndb.de>
References: <1BAFE6F6C881BF42822005164F1491C33EA35352@DBDE01.ent.ti.com>
 <4FF5733E.6000604@gmail.com> <201207051536.45920.arnd@arndb.de>
Message-ID: <4FF5BB34.9070002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.07.2012 17:36, Arnd Bergmann wrote:
> On Thursday 05 July 2012, Daniel Mack wrote:
>> On 04.07.2012 14:48, Hebbar, Gururaja wrote:
>>> All,
>>>
>>> Are there any plans or work going on for providing Device Tree Support for Davinci
>>> ASoC?
>>>
>>> I am planning to add DT support for TI AM335x (McASP) and I don't want to do duplicate
>>> task.
>>
>> That's good to know. But isn't there a dependency on the EDMA engine? Is
>> that part ported yet?
> 
> None of the dma engines are ported yet, because the generic binding for dma
> engines is still under debate. So far, all DMA channels are described using
> auxdata on platforms that use DT, with the exception of exynos, but that one
> will have to change once we have the common code.

You're talking about the DT bindings here, right? But the code itself is
also only present in TI's BSP kernel sources, and not in mainline.


Daniel

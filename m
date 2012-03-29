From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 29 Mar 2012 16:08:00 +0200
Subject: [GIT PULL] ARM: OMAP: i2c, gpio, spi,
 regulator and mmc DTS updates
In-Reply-To: <201203150801.13183.arnd@arndb.de>
References: <4F612C29.40608@ti.com> <20120315004638.GW12083@atomide.com>
 <201203150801.13183.arnd@arndb.de>
Message-ID: <4F746CC0.9050507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

On 3/15/2012 9:01 AM, Arnd Bergmann wrote:
> On Thursday 15 March 2012, Tony Lindgren wrote:
>> * Cousson, Benoit<b-cousson@ti.com>  [120314 16:41]:
>>> Hi Tony,
>>>
>>> Here are the remaining DTS patches for 3.4.
>>>
>>> On top of the previous pull request, I just added the MMC DTS since the driver adaptation just got queued.
>>>
>>> It will be still be good to have that for 3.4 if possible, otherwise we will
>>> have a bunch of drivers DT adapted but no DTS file to use them :-(
>>
>> This might be doable as a follow-up patch series at the end
>> of the merge window or at -rc1 when the related driver changes
>> have been merged.
>>
>> Arnd and Olof, what do you guys think?
>
> I'll have to look at the patches more closely, but from the diffstat it definitely
> looks ok for a later merge once the driver is in. If you can rebase the branch on
> top of the mmc tree (or the merge of that tree with whatever else is needed), it
> should give us a bisectable history and I can stick it into a late/* branch right
> away.

FYI, MMC DT adaptation just got merged, I2C, GPIO, SPI, regulator DT 
adaptation were already merged before, so it means that this branch can 
be merged to take advantage of all the DT adapted drivers.

Thanks,
Benoit

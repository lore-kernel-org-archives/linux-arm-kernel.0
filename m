From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 1 Sep 2011 13:59:13 +0200
Subject: [PATCH 7/7] OMAP2+: devices: Remove all omap_device_pm_latency
	structures
In-Reply-To: <87sjoh6wnj.fsf@ti.com>
References: <1314026347-21623-1-git-send-email-b-cousson@ti.com>
	<1314026347-21623-8-git-send-email-b-cousson@ti.com>
	<87sjoh6wnj.fsf@ti.com>
Message-ID: <4E5F7391.7060602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/1/2011 12:31 AM, Hilman, Kevin wrote:
> Benoit Cousson<b-cousson@ti.com>  writes:
>
>> Remove all these duplicated structures since a default one is now
>> available.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>> ---
>>   arch/arm/mach-omap2/devices.c    |   46 +++----------------------------------
>>   arch/arm/mach-omap2/display.c    |   11 +--------
>>   arch/arm/mach-omap2/dma.c        |   11 +--------
>>   arch/arm/mach-omap2/gpio.c       |   12 +---------
>>   arch/arm/mach-omap2/hsmmc.c      |   18 +--------------
>>   arch/arm/mach-omap2/hwspinlock.c |   12 +---------
>>   arch/arm/mach-omap2/mcbsp.c      |   11 +--------
>>   arch/arm/mach-omap2/serial.c     |   25 +-------------------
>>   arch/arm/mach-omap2/sr_device.c  |   11 +--------
>>   arch/arm/mach-omap2/usb-musb.c   |   11 +--------
>>   arch/arm/plat-omap/i2c.c         |   10 +-------
>>   11 files changed, 14 insertions(+), 164 deletions(-)
>
> Nice!  queuing this for v3.2 (branch: for_3.2/omap_device)

Thanks,
Benoit

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 03 Aug 2012 18:27:41 +0200
Subject: [PATCH] SPI: MXS: Allow to pass the SPI master bus number from
 the device tree
In-Reply-To: <20120803144326.GE23791@S2101-09.ap.freescale.net>
References: <1343076052-27312-1-git-send-email-marex@denx.de>
 <1344004239-22868-1-git-send-email-maxime.ripard@free-electrons.com>
 <20120803144326.GE23791@S2101-09.ap.freescale.net>
Message-ID: <501BFBFD.7060002@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/08/2012 16:43, Shawn Guo a ?crit :
> On Fri, Aug 03, 2012 at 04:30:39PM +0200, Maxime Ripard wrote:
>> If you don't do it, the bus number will be a bogus value, possibly used
>> for device file names in drivers like spidev.
>>
> Do you see any problem with that?  Here is the take from Grant.
> 
> http://thread.gmane.org/gmane.linux.kernel.spi.devel/9839/focus=9863

Ok, I didn't see this thread, obviously.

Thanks,
Maxime


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

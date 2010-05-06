From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Thu, 06 May 2010 12:05:34 +0200
Subject: [PATCH] ARM: S3C64XX: Add USB clock source frequency as driver
	data to s3c-hsotg
In-Reply-To: <20100506012608.GB6684@trinity.fluff.org>
References: <4BE00124.7030702@gmail.com>
	<20100506012608.GB6684@trinity.fluff.org>
Message-ID: <4BE2946E.1080508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Op 06-05-10 03:26, Ben Dooks schreef:
> On Tue, May 04, 2010 at 01:12:36PM +0200, Maurus Cuelenaere wrote:
>   
>> The upcoming SmartQ machines use a different base clock frequency
>> for the USB block, this patch allows passing it as platform data
>> to the driver.
>>     
> When I merge thomas' patch for addign a clock for this crystal, it might
> be worth changing the driver to get this and see what rate the clock is
> at by that method.
>   

Do you mean [PATCH] ARM: S5P: Add USB External Crystal clock definition?
Other then that I can't really find any USB clock related patches.

> Will hold off on this patch, also going to do some woth on the hsotg
> driver anyway, since it could really do with some work on DMA support
> and some debugging.
>   

-- 
Maurus Cuelenaere

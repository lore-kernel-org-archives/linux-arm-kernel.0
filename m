From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 09 Jun 2011 11:23:14 +0200
Subject: [PATCH] arm: omap3: beagle: Ensure msecure is mux'd to be able
	to set the RTC
In-Reply-To: <4DF078E4.8040903@compulab.co.il>
References: <4D9AEB76.2060509@ahsoftware.de>
	<1302010808-3065-1-git-send-email-holler@ahsoftware.de>
	<20110531102903.GU11352@atomide.com>
	<4DEDDAF6.2070505@ahsoftware.de> <4DEDF451.1080604@compulab.co.il>
	<4DEE0858.2020308@ahsoftware.de> <4DEFF035.4070004@compulab.co.il>
	<4DF0120E.5030204@ahsoftware.de> <4DF078E4.8040903@compulab.co.il>
Message-ID: <4DF09102.9080503@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Am 09.06.2011 09:40, schrieb Igor Grinberg:
> On 06/09/11 03:21, Alexander Holler wrote:

> I see. Is the new patch version somehow provides better functionality?
> You configure the gpio for output, this means that the pin is actually driven
> and not just relies on internal pullup (which can vary from chip to chip).
> I know nothing about that msecure stuff, but may be it is better to drive the pin,
> then just configuring the mux (enabling internal pullup)...

Just using the internal pullup was enough with my BeagleBoard C4.

>> Below is an updated version. The gpio_export() might be removed too.
>
> The original patch version is already in Linus' tree, so this one will not apply as it is.
> If you decide it is better then the original one, then it must be rebased.
> Otherwise, looks OK.

I'm fine with either version, so no new patch is necessary. ;)

Regards,

Alexander

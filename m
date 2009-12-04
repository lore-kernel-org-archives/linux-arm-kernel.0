From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Fri, 04 Dec 2009 09:39:35 +0100
Subject: [PATCH] mx31moboard: fix typo
In-Reply-To: <20091203193321.GE22533@pengutronix.de>
References: <20091203193034.GD22533@pengutronix.de>
	<20091203193321.GE22533@pengutronix.de>
Message-ID: <4B18CAC7.30907@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Schwebel wrote:
> On Thu, Dec 03, 2009 at 08:30:34PM +0100, Robert Schwebel wrote:
>> Currently, linux-next breaks due to a typo introduced in commit
>> 33c4d91928bea4444b067e620496befbeb87029c
>>
>> This patch fixes it.

Thanks for fixing the typo, I gave me one warning that I had never noticed.

> 
> But something else must be missing, I still get this:
> 
> arch/arm/mach-mx3/mx31moboard.c: In function 'moboard_usbh2_init':
> arch/arm/mach-mx3/mx31moboard.c:395: error: 'mx31_usbh2' undeclared (first use in this function)
> arch/arm/mach-mx3/mx31moboard.c:395: error: (Each undeclared identifier is reported only once
> arch/arm/mach-mx3/mx31moboard.c:395: error: for each function it appears in.)
> make[1]: *** [arch/arm/mach-mx3/mx31moboard.o] Error 1
> 

This comes from the usb host support for mx31 that should come with 
2.6.33. Does linux-next already include these patches ?

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne

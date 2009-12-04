From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Fri, 04 Dec 2009 12:14:04 +0100
Subject: [PATCH] mx31moboard: fix typo
In-Reply-To: <4B18CAC7.30907@epfl.ch>
References: <20091203193034.GD22533@pengutronix.de>
	<20091203193321.GE22533@pengutronix.de> <4B18CAC7.30907@epfl.ch>
Message-ID: <4B18EEFC.8030904@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Valentin Longchamp wrote:
> Robert Schwebel wrote:
> 
>> But something else must be missing, I still get this:
>>
>> arch/arm/mach-mx3/mx31moboard.c: In function 'moboard_usbh2_init':
>> arch/arm/mach-mx3/mx31moboard.c:395: error: 'mx31_usbh2' undeclared (first use in this function)
>> arch/arm/mach-mx3/mx31moboard.c:395: error: (Each undeclared identifier is reported only once
>> arch/arm/mach-mx3/mx31moboard.c:395: error: for each function it appears in.)
>> make[1]: *** [arch/arm/mach-mx3/mx31moboard.o] Error 1
>>
> 
> This comes from the usb host support for mx31 that should come with 
> 2.6.33. Does linux-next already include these patches ?
> 

Hum, sorry, my bad, this was based on mxc_master_*pu* (don't ask me why, 
maybe not enough coffee). This branch includes the changes for using soc 
specific defines by Sascha.

Sacha, any chance these hit mainline/next soon ? Or do you want me to 
send correcting patch ?

Thanks

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne

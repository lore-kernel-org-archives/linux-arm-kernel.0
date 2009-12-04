From: sha@pengutronix.de (Sascha Hauer)
Date: Fri, 4 Dec 2009 13:20:45 +0100
Subject: [PATCH] mx31moboard: fix typo
In-Reply-To: <4B18EEFC.8030904@epfl.ch>
References: <20091203193034.GD22533@pengutronix.de>
	<20091203193321.GE22533@pengutronix.de>
	<4B18CAC7.30907@epfl.ch> <4B18EEFC.8030904@epfl.ch>
Message-ID: <20091204122045.GQ15126@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2009 at 12:14:04PM +0100, Valentin Longchamp wrote:
> Valentin Longchamp wrote:
>> Robert Schwebel wrote:
>>
>>> But something else must be missing, I still get this:
>>>
>>> arch/arm/mach-mx3/mx31moboard.c: In function 'moboard_usbh2_init':
>>> arch/arm/mach-mx3/mx31moboard.c:395: error: 'mx31_usbh2' undeclared (first use in this function)
>>> arch/arm/mach-mx3/mx31moboard.c:395: error: (Each undeclared identifier is reported only once
>>> arch/arm/mach-mx3/mx31moboard.c:395: error: for each function it appears in.)
>>> make[1]: *** [arch/arm/mach-mx3/mx31moboard.o] Error 1
>>>
>>
>> This comes from the usb host support for mx31 that should come with  
>> 2.6.33. Does linux-next already include these patches ?
>>
>
> Hum, sorry, my bad, this was based on mxc_master_*pu* (don't ask me why,  
> maybe not enough coffee). This branch includes the changes for using soc  
> specific defines by Sascha.
>
> Sacha, any chance these hit mainline/next soon ? Or do you want me to  
> send correcting patch ?

Please send a fixup patch.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

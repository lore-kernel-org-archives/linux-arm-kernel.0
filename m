From: pieterg@gmx.com (pieterg)
Date: Thu, 8 Jul 2010 17:59:36 +0200
Subject: machine definition for colibri-pxa3xx
In-Reply-To: <201007081718.02814.marek.vasut@gmail.com>
References: <201007081236.39550.pieterg@gmx.com>
	<201007081455.16353.pieterg@gmx.com>
	<201007081718.02814.marek.vasut@gmail.com>
Message-ID: <201007081759.36838.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 July 2010 17:18:02 Marek Vasut wrote:
> http://openpxa.sourceforge.net , you might want to try it ;-) There is
> actually a stable release and there are some more nice additions in GIT.

Nice progress.
When I started with the pxa3xx you weren't that far yet with your IPL. I now 
have a bootloader which does all I need (show splash screen, read i2c 
eeprom, load kernel from nand, boot).
But I'd like to give your IPL a try, see if it is faster than the modded 
nand_spl that I ended up using ;)

Rgds, Pieter

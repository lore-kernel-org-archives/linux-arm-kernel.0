From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 8 Jul 2010 22:07:45 +0200
Subject: machine definition for colibri-pxa3xx
In-Reply-To: <201007081759.36838.pieterg@gmx.com>
References: <201007081236.39550.pieterg@gmx.com>
	<201007081718.02814.marek.vasut@gmail.com>
	<201007081759.36838.pieterg@gmx.com>
Message-ID: <201007082207.45938.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 8. ?ervence 2010 17:59:36 pieterg napsal(a):
> On Thursday 08 July 2010 17:18:02 Marek Vasut wrote:
> > http://openpxa.sourceforge.net , you might want to try it ;-) There is
> > actually a stable release and there are some more nice additions in GIT.
> 
> Nice progress.
> When I started with the pxa3xx you weren't that far yet with your IPL. I
> now have a bootloader which does all I need (show splash screen, read i2c
> eeprom, load kernel from nand, boot).
> But I'd like to give your IPL a try, see if it is faster than the modded
> nand_spl that I ended up using ;)
> 
> Rgds, Pieter

The GIT version is tuned for speed (the CPU doesn't run on the lowest frequency 
anymore as in the release version).

How to compile that GIT version you can find on the website. You'll need both U-
Boot and OBM2 from GIT for that though!

btw. I recall you being quite dissatisfied with the old OpenPXA version, but I 
hope it moved further now :) And hey, developers are welcome, it's still one man 
show so it takes time to make some progress :(

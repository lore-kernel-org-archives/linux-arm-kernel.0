From: pieterg@gmx.com (pieterg)
Date: Sat, 18 Sep 2010 16:04:25 +0200
Subject: [Openpxa-users] colibri pxa320 NAND errors
In-Reply-To: <201009181219.38933.marek.vasut@gmail.com>
References: <201009161827.04823.pieterg@gmx.com>
	<201009181219.38933.marek.vasut@gmail.com>
Message-ID: <201009181604.25548.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 18 September 2010 12:19:38 Marek Vasut wrote:
> Dne ?t 16. z??? 2010 18:27:04 pieterg napsal(a):
> > I'm getting a whole lot of single bit errors, and also many double bit
> > errors. As a result, my filesystem gets corrupted, even after a single
> > reboot.
>
> Maybe the NAND's misconfigured, what bootloader do you use ?

I'm using u-boot.
Mostly 2009.3, but to rule out bad NAND configuration, I've tried the latest 
u-boot-pxa branch, with the same results:

> > To make sure it's not my heavily modified old 2009.3 u-boot, which is
> > causing the problems because of some faulty nand controller
> > configuration, I've just built the latest openpxa u-boot, and booted it
> > with OBM2. But the results are the same.

Rgds, Pieter

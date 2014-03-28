From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 28 Mar 2014 11:13:50 +0100
Subject: [PATCHv2 1/1] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <53354329.2020909@freescale.com>
References: <532BCFCC.4080205@freescale.com>
 <1395399017-19005-1-git-send-email-LW@KARO-electronics.de>
 <20140324095902.GB11377@localhost>
 <20140326095156.3e5585b8@ipc1.ka-ro>
 <5332AEE7.2040402@freescale.com>
 <20140326125502.0e8d0657@ipc1.ka-ro>
 <20140327095956.GA29623@localhost>
 <20140327132109.06258526@ipc1.ka-ro>
 <5334D9F7.2030001@freescale.com>
 <20140328091646.1ce03f90@ipc1.ka-ro>
 <53353524.9020605@freescale.com>
 <20140328100158.042a3d68@ipc1.ka-ro>
 <533541DE.7020606@freescale.com> <53354329.2020909@freescale.com>
Message-ID: <20140328111350.003b9fce@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Huang Shijie wrote:
> ? 2014?03?28? 17:33, Huang Shijie ??:
> > ? 2014?03?28? 17:01, Lothar Wa?mann ??:
> >> There is no need for the ROM code to access any other partition than
> >> the bootloader itself. Thus Linux can perfectly well be booted from
> > Assume the ROM only access the partition which contains the 
> > bootloader, and
> > the ROM does the swapping for the pages(but we do not do the swapping 
> > to these pages),
> I mean the kernel do not do the swapping when we burn the uboot to the NAND.
> 
The kernel need not be able to write the bootloader to NAND. 
If you want a kernel that can do it, you just need to boot it with one
line in the DTB removed.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

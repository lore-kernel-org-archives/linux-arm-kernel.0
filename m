From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 28 Mar 2014 09:16:46 +0100
Subject: [PATCHv2 1/1] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <5334D9F7.2030001@freescale.com>
References: <532BCFCC.4080205@freescale.com>
 <1395399017-19005-1-git-send-email-LW@KARO-electronics.de>
 <20140324095902.GB11377@localhost>
 <20140326095156.3e5585b8@ipc1.ka-ro>
 <5332AEE7.2040402@freescale.com>
 <20140326125502.0e8d0657@ipc1.ka-ro>
 <20140327095956.GA29623@localhost>
 <20140327132109.06258526@ipc1.ka-ro>
 <5334D9F7.2030001@freescale.com>
Message-ID: <20140328091646.1ce03f90@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Huang Shijie wrote:
> ? 2014?03?27? 20:21, Lothar Wa?mann ??:
> > I can assure you that the>100.000 i.MX28 based modules, that we sold
> > up to now boot from NAND just fine without any block mark swapping in
> > the U-Boot pages.
> >
> Our driver should follow the Reference manual, not the product.
> 
Still there is no need for the Linux NAND driver to be able to read or
write partitions in a format that the Boot ROM can understand. Thus it
is perfectly legal to allow disregarding the BB marks and solely rely on
a flash based BBT.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

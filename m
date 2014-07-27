From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Sun, 27 Jul 2014 11:58:04 +0200
Subject: [PATCH] ARM: i.MX: Remove mach-cpuimx27sd board file
In-Reply-To: <1406441904.434548412@f350.i.mail.ru>
References: <1406382068-13452-1-git-send-email-shc_work@mail.ru>
 <20140726202042.6979888c@e6520eb>
 <1406441904.434548412@f350.i.mail.ru>
Message-ID: <20140727115804.455a7e61@e6520eb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

Le Sun, 27 Jul 2014 10:18:24 +0400,
Alexander Shiyan <shc_work@mail.ru> a ?crit :

> Sat, 26 Jul 2014 20:20:42 +0200 ?? Eric B?nard <eric@eukrea.com>:
> > Le Sat, 26 Jul 2014 17:41:08 +0400,
> > Alexander Shiyan <shc_work@mail.ru> a ?crit :
> > 
> > > 
> > > eukrea_mbimx27-baseboard.c and mach-cpuimx27.c can be replaced with their
> > > devicetree equivalents: imx27-eukrea-mbimxsd27-baseboard.dts and
> > > imx27-eukrea-cpuimx27.dtsi respectively, so remove the board files.
> > > 
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > Acked-by: Eric B?nard <eric@eukrea.com>
> > 
> > Thanks !
> 
> Can I make a similar patch for Eukrea-i.MX25/35 boards?
> 
I have to check with Denis if we have the same level of support in DT
before, then we can remove the non DT support.

Eric

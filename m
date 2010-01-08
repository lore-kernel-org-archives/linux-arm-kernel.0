From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Fri, 8 Jan 2010 10:35:18 +0100
Subject: S3C2440 : DM9000 link down when writing on NAND flash
In-Reply-To: <20100108100805.15e4b558@jvermillard-portable>
References: <20100108100805.15e4b558@jvermillard-portable>
Message-ID: <19270.64598.451295.134378@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> I'm using a DM9000E with a S3C2440 CPU running 2.6.30.1. The DM9K is
> connected on the CS4 (like the mini2440). I already had troubles with
> the ethernet, and we applied (as suggested here) the DM900 errata
> consisting in gating IOR & CS. The DM9000 is working better now, but
> when I write some file on the NAND Flash, the DM900 is reseting (link
> down, link up). Reading from NAND flash is fine.
> 
I remember to have seen this before. You should search the archives of
the old linux-arm-kernel mailinglist.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

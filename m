From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 20 Mar 2014 10:21:53 +0100
Subject: [PATCH] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <532AB1A2.9010702@freescale.com>
References: <1395235406-13449-1-git-send-email-y>
 <532AB1A2.9010702@freescale.com>
Message-ID: <20140320102153.7106f915@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Huang Shijie wrote:
> ? 2014?03?19? 21:23, y at karo-electronics.de ??:
> > configurable via DT. This is required for the Ka-Ro electronics
> > platforms.
> >
> If you disable the swapping, you will disable the NAND boot in actually.
> 
No. All our modules do boot from NAND and none of them does the
swapping.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

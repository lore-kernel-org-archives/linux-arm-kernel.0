From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 20 Mar 2014 10:20:29 +0100
Subject: [PATCH] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <201403200933.39382.jbe@pengutronix.de>
References: <1395235406-13449-1-git-send-email-y>
 <201403200933.39382.jbe@pengutronix.de>
Message-ID: <20140320102029.4327a6c0@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Juergen Beisert wrote:
> Hi Lothar,
> 
> On Wednesday 19 March 2014 14:23:26 y at karo-electronics.de wrote:
> > With a flash-based BBT there is no reason to move the Factory Bad
> > Block Marker from the data area buffer (to where it is mapped by the
> > GPMI NAND controller) to the OOB buffer. Thus, make this feature
> > configurable via DT. This is required for the Ka-Ro electronics
> > platforms.
> > [...]
> 
> How do you create the BBT the very first time with valuable data when the NAND 
> already contains factory bad blocks?
> 
With the flashtool that does the initial flash programming.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

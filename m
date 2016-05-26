From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 26 May 2016 10:13:30 +0300
Subject: =?UTF-8?B?UmU6IE1vZGVybiBrZXJuZWwgb24gYSBDaHVtYnk=?=
In-Reply-To: <4758440.JnRBmYVBjM@wuerfel>
References: <CAMW5UfYH6UiaB1ddRT0KBP1thyyebnCw2h4VigYQQ55v4MYqdA@mail.gmail.com>
 <4758440.JnRBmYVBjM@wuerfel>
Message-ID: <1464246810.783789508@f42.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> ???????, 26 ??? 2016, 0:09 +03:00 ?? Arnd Bergmann <arnd@arndb.de>:
> 
> On Wednesday, May 25, 2016 4:59:31 PM CEST Josh Coombs wrote:
> > I've likely bitten off way more than I can chew but I'd like to see if
> > this is possible:  I have a i.MX21 powered 'original' Chumby happily
> > running on a modified 2.6.16 kernel, ideally I'd like to do the
> > legwork to get it running on a current, mainline kernel.  Looking at
> > 4.6 I see a single i.MX21 device supported by a board file, the
> > mx21ads.  Flipping through the list archives I see discussions of
> > i.MX21 being moved to device tree operation but I can't see any signs
> > of any such devices actually being supported that way.
> > 
> > Should I try to bash up support based on the mx21ads or is there a
> > device tree template I can start from?
> 
> I think your best bet is to start from the imx27 DT support.
> As I understand, it's closely related to imx21, though it's possible
> that you have to add some other drivers.
> 
> Alexander Shiyan (added to Cc here) has written DT support for the imx21
> clk controller, he may have other patches that never made it upstream,
> or have additional information.

Hello.

i.MX21 platform is fully ready for use with DT. To start using DT You need to write
imx21-dt machine startup (which is almost identical to imx27-dt) and basic DT
templates imx21-pinfunc.h & imx21.dtsi and so on. Then you can write DT-support
for your board.
I have no any additional patches for i.MX21.

Thanks.
---

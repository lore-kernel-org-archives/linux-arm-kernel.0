From: insane79@yandex.ru (Dennis Semakin)
Date: Mon, 08 Feb 2010 12:38:06 +0300
Subject: [PXA320] How to find I/O registers,
	base address of ASIX ethernet chip?
In-Reply-To: <20100208091348.GC15255@pengutronix.de>
References: <19621265275300@webmail108.yandex.ru>
	<20100205042655.GR28972@buzzloop.caiaq.de>
	<33291265356930@webmail116.yandex.ru>
	<20100207051343.GL9007@buzzloop.caiaq.de>
	<33061265619560@webmail103.yandex.ru>
	<20100208091348.GC15255@pengutronix.de>
Message-ID: <18311265621886@webmail106.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



08.02.10, 10:13, "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de>:

> On Mon, Feb 08, 2010 at 11:59:20AM +0300, Dennis Semakin wrote:
>  > Hello
>  > 
>  > >  > In U-BOOT:
>  > >  > 
>  > >  > MSC1 (address 0x4a00000c) - 0x0779
>  > >  > $ md.w 0x4a00000c
>  > >  > 4a00000c: 0779 0000 0000 0000 0000 0000 0000 0000 y...............
>  > >  > 4a00001c: 0008 0000 0000 0000 0000 0000 0000 0000 ................
>  > >  > 4a00002c: 0000 0000 0000 0000 0000 0000 0000 0000 ................
>  > >  > 4a00003c: 0000 0000 0000 0000 0000 0000 0000 0000 ................
>  > >  > 
>  > >  > CSADRCFG2 (address 0x4a000088) - 0032c809
>  > >  > $ md.l 0x4a000088
>  > >  > 4a000088: 0032c809 00020000 00020000 00000000 ..2.............
>  > >  > 4a000098: 00000000 00000000 00000000 00000000 ................
>  > >  > 4a0000a8: 00000000 00000000 00000000 00000000 ................
>  > >  > 4a0000b8: 00000000 00000000 00000000 00000000 ................
>  > >  > 4a0000c8: 00000000 00000000 00000000 00000000 ................
>  > >  
>  > >  Can you access 0x1000_0000 from U-Boot? Did you switch on the clock for
>  > >  the static bus? This is also not done by the kernel currently.
>  > >  
>  > >  Daniel
>  > >  
>  > >  
>  > 
>  > No, I cannot access 0x1000_0000 from U-Boot. The system hangs, when I access to this address
>  This sounds like a missing clock.  Ah, and Daniel already asked that,
>  too: "Did you switch on the clock for the static bus?"
>  
>  Best regards
>  Uwe
>  
>  -- 
>  Pengutronix e.K.                              | Uwe Kleine-K?nig            |
>  Industrial Linux Solutions                    | http://www.pengutronix.de/  |
>  
>  

Well... I yet do not know how to do this...

From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 2 Nov 2010 18:29:25 +0100
Subject: [patch v3 01/10] efikamx: read board id
In-Reply-To: <20101102104751.GS31158@pengutronix.de>
References: <20101026200723.839428019@rtp-net.org>
	<20101026200953.996305184@rtp-net.org>
	<86A0E76937111F4C92FABEC0A20988510523CAD8@az33exm21>
	<87iq0g6pbg.fsf@lechat.rtp-net.org>
	<20101102104751.GS31158@pengutronix.de>
Message-ID: <20101102172925.GF6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 02, 2010 at 11:47:51AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> > Also, such a specific treatment for configuring theses GPIOs means for
> > me more errors/bugs possible.
> I suggest to just use one of the two possibilies for now (I don't have a
> strong preference here).  Hopefully Lothar's patch that makes the pad
> definitions use a bit field[1] is merged soon and then this can become:
> 
> 	#define MX51_PAD_PCBID0	(MX51_PAD_GPIOXY | PAD_CTL_PUS_100K_UP)

I just opened up a imx-for-2.6.38 branch which contains Lothars patch,
so give it a try.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

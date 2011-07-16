From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 16 Jul 2011 13:56:55 +0200
Subject: [PATCH 4/7] at91: remove non used at91_spi.h
In-Reply-To: <20110716105752.GD20678@game.jcrosoft.org>
References: <1310687525-22486-1-git-send-email-plagnioj@jcrosoft.com>
	<1310687525-22486-4-git-send-email-plagnioj@jcrosoft.com>
	<4E2028E1.1060603@vollmann.ch>
	<20110715154636.GA20678@game.jcrosoft.org>
	<4E206E7D.2070708@vollmann.ch>
	<20110716105752.GD20678@game.jcrosoft.org>
Message-ID: <20110716115655.GA1992@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > About the SPI driver:
> > From Documentation/spi/spi-summary:
> > "At this writing, Linux has no slave side programming interface."
> > So there's no SPI framwork that covers the slave side.
> This what I mean use the SPI framework and add the SPI Slave support there

[CCing spi-devel]

If you talk about SPI slaves, be sure to have read Grant's comments in

http://thread.gmane.org/gmane.linux.kernel.spi.devel/7401

to see what would be needed for slave support. Short note: Would be
seperate subsystem, master subsystem is of limited use. I think a few
slave-drivers would be nice to evaluate, so one can get a feeling if a
subsystem makes sense and if so, how it could look like.

Detlef, have you posted your slave driver so far?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110716/3aee55a5/attachment.sig>

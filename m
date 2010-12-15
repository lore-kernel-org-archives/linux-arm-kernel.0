From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Wed, 15 Dec 2010 16:19:15 +0100
Subject: [PATCH] i.MX51: Full iomux support
In-Reply-To: <20101215151528.GD29833@pengutronix.de>
References: <1292421691-14615-1-git-send-email-s.hauer@pengutronix.de>
	<87y67rcdnf.fsf@lechat.rtp-net.org>
	<20101215151528.GD29833@pengutronix.de>
Message-ID: <19720.56435.675373.277522@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sascha Hauer writes:
> On i.MX51 there are several pins which do not have a sel_input register
> associated (I2C) and so setting the SION bit becomes mandatory. On the
> other hand not all pins have a SION bit. I'm confused...
> 
sel_input has nothing to do with SION. sel_input is an additional
multiplexer that can route one of different pads for a given internal
function.
SION (according to the spec) enables the input path of a pad no matter
what function is chosen.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

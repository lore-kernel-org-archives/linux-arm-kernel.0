From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 5 Jun 2012 13:40:37 +0100
Subject: Freescale fec.c driver breakage
In-Reply-To: <4FCDFD4E.1000906@snapgear.com>
References: <4FCC3CB4.5030107@snapgear.com>
 <20120604081937.GH30400@pengutronix.de>
 <20120604091616.GA3943@opensource.wolfsonmicro.com>
 <4FCDAD5B.8010106@snapgear.com>
 <20120605094141.GE23408@opensource.wolfsonmicro.com>
 <4FCDF8BE.6010509@snapgear.com>
 <20120605122444.GS23408@opensource.wolfsonmicro.com>
 <4FCDFD4E.1000906@snapgear.com>
Message-ID: <20120605124037.GT23408@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2012 at 10:36:30PM +1000, Greg Ungerer wrote:

> I am pretty sure AHB was bolted on later. This FEC core has progressed
> from very old Motorola PowerPC platforms to ColdFire/M68k to ARM, over
> something coming close to a 20 year period. In the earlier uses of it
> there is quite a few differences (including some quite odd register
> layout differences).

> There may be other things that are somewhat like an ahb clock and ipg
> clock, but really these are things that have come along later with a
> specific platform implementation.

For AHB that sounds plausible, but for the IPG clock (assuming I've
identified the function correctly) I've got a very hard time believing
that the IP ever didn't need a clock - my understanding is that it's the
master clock for the IP ("IP gate").
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120605/25fb6aef/attachment.sig>

From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 4 Jan 2010 18:49:19 +0000
Subject: Ethernet / SD Boot
In-Reply-To: <4B422545.2000509@warmcat.com>
References: <20091228224435.GA23617@sirena.org.uk>
	<4B39D439.9070909@warmcat.com>
	<20091229123348.GB5784@opensource.wolfsonmicro.com>
	<4B39FB2C.4010608@warmcat.com>
	<20091230131559.GA369@opensource.wolfsonmicro.com>
	<4B3B579E.8030105@warmcat.com>
	<20091231122727.GA5613@opensource.wolfsonmicro.com>
	<4B3CA02D.9000208@warmcat.com> <4B42169E.5040007@simtec.co.uk>
	<4B422545.2000509@warmcat.com>
Message-ID: <20100104184919.GA13537@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fwiw:

1. 100% of CPUs I've used don't have SD boot.
2. I don't want to fiddle about with removing and replacing an SD card
   every time I change the kernel / bootloader.
   Give me a cable and computer!
3. It's good to have a debricking strategy, but even better if it's the
   same as or similar to the regular development strategy - better
   test coverage, less knowledge to get lost.
4. Thus hardware USB boot is surely best, and TFTP the next best :-)
5. JTAG board connectivity is sometimes done with Perl and parallel ports
   too; it's not reserved only for expensive dev packages.

-- Jamie

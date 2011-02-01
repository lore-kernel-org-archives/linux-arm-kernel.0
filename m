From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 01 Feb 2011 17:25:51 +0000
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <20110201142845.GJ31216@n2100.arm.linux.org.uk>
References: <20110124162400.GC24104@n2100.arm.linux.org.uk>
	<000101cbbbe5$45d47ed0$d17d7c70$@moll@arm.com>
	<20110124165356.GG24104@n2100.arm.linux.org.uk>
	<20110124170304.GH24104@n2100.arm.linux.org.uk>
	<000201cbbbef$bcec4610$36c4d230$@moll@arm.com>
	<20110124180944.GK24104@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911F432EF@GEORGE.Emea.Arm.com>
	<20110124231050.GP24104@n2100.arm.linux.org.uk>
	<20110201111821.GC31216@n2100.arm.linux.org.uk>
	<1296567299.2768.40.camel@hornet.cambridge.arm.com>
	<20110201142845.GJ31216@n2100.arm.linux.org.uk>
Message-ID: <1296581151.2768.57.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> So, I do hope that someone decides to implement something more reasonable
> if Versatile Express were to get a DMA controller.  If it's another PL08x
> then it isn't worth it - it won't work.

More likely it will be DMA-330 formerly known as PL330. But as I said -
it's about the chip that Core Tile carries (whether it's feasible to
squeeze it inside).

Alternatively one could use Logic Tile (FPGA based) in the second
daughterboard site with an engine implementation, but I don't expect
many users willing to pay $$$$ just for this reason :-)

Cheers!

Pawe?

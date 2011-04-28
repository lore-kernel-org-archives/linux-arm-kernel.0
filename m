From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 09:35:47 +0100
Subject: [PATCH] clkdev: add support to lookup for early platform device
In-Reply-To: <20110428051203.GB3852@game.jcrosoft.org>
References: <20110427084247.GK17290@n2100.arm.linux.org.uk>
	<20110427103145.GF29103@game.jcrosoft.org>
	<20110427104758.GG29103@game.jcrosoft.org>
	<20110427150057.GH29103@game.jcrosoft.org>
	<20110428020910.GA13539@linux-sh.org>
	<20110428024559.GK29103@game.jcrosoft.org>
	<20110428030817.GC13539@linux-sh.org>
	<20110428031704.GL29103@game.jcrosoft.org>
	<20110428033808.GE13539@linux-sh.org>
	<20110428051203.GB3852@game.jcrosoft.org>
Message-ID: <20110428083547.GM17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 07:12:03AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> How did you manage to get the clock for the earlytimer?

This is getting silly.  "Let's move all our devices to early" is insane.
I can see someone then wanting an early-early-device because early has
become just too late in the initialization.

Come on guys, keep it simple and stop trying to contort the interfaces
you're given into doing things they're not designed to do.

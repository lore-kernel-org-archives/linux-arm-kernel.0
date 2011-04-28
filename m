From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 28 Apr 2011 11:26:13 +0200
Subject: [PATCH] clkdev: add support to lookup for early platform device
In-Reply-To: <20110428083547.GM17290@n2100.arm.linux.org.uk>
References: <20110427103145.GF29103@game.jcrosoft.org>
	<20110427104758.GG29103@game.jcrosoft.org>
	<20110427150057.GH29103@game.jcrosoft.org>
	<20110428020910.GA13539@linux-sh.org>
	<20110428024559.GK29103@game.jcrosoft.org>
	<20110428030817.GC13539@linux-sh.org>
	<20110428031704.GL29103@game.jcrosoft.org>
	<20110428033808.GE13539@linux-sh.org>
	<20110428051203.GB3852@game.jcrosoft.org>
	<20110428083547.GM17290@n2100.arm.linux.org.uk>
Message-ID: <20110428092613.GD3852@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:35 Thu 28 Apr     , Russell King - ARM Linux wrote:
> On Thu, Apr 28, 2011 at 07:12:03AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > How did you manage to get the clock for the earlytimer?
> 
> This is getting silly.  "Let's move all our devices to early" is insane.
> I can see someone then wanting an early-early-device because early has
> become just too late in the initialization.
> 
> Come on guys, keep it simple and stop trying to contort the interfaces
> you're given into doing things they're not designed to do.
I agress but I need to pass resources to the timer so early devices make sense

Best Regards,
J.

From: marex@denx.de (Marek Vasut)
Date: Mon, 21 May 2012 04:40:09 +0200
Subject: [PATCH 1/4] GPMI-NAND: Define ecc.strength
In-Reply-To: <20120521014121.GO5427@S2101-09.ap.freescale.net>
References: <1337562140-5739-1-git-send-email-marex@denx.de>
 <201205210336.41860.marex@denx.de>
 <20120521014121.GO5427@S2101-09.ap.freescale.net>
Message-ID: <201205210440.09310.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Mon, May 21, 2012 at 03:36:41AM +0200, Marek Vasut wrote:
> > Dear Shawn Guo,
> > 
> > > So non-DT probe has the same issue?  Or this is a DT probe only issue?
> > 
> > I started using DT, so I'm now fixing everything to work like it used to.
> > Damn this DT conversion broke about everything.
> 
> So you are saying the issue is introduced by gpmi-nand DT conversion?

I doubt so ... but noone ever could test it without DT bindings as you 
NAKed/stalled every single attempt to add the platform binding code. So this 
code was rotting in the tree, who knows how many bugs are still in it. Now I 
guess it's about time to start squashing the bugs.

Best regards,
Marek Vasut

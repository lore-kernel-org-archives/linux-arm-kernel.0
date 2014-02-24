From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 24 Feb 2014 12:35:32 -0500
Subject: [PATCH] ARM: mvebu: Armada 375/38x depend on MULTI_V7
In-Reply-To: <20140224123115.GC18601@lunn.ch>
References: <1393174030-10549-1-git-send-email-jason@lakedaemon.net>
 <20140224123115.GC18601@lunn.ch>
Message-ID: <20140224173532.GH14250@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 01:31:15PM +0100, Andrew Lunn wrote:
> On Sun, Feb 23, 2014 at 04:47:10PM +0000, Jason Cooper wrote:
> > During this release cycle, we're adding the new Armada 375, 380, and 385
> > SoCs.  We're also migrating DT kirkwood boards into mach-mvebu.  The
> > kirkwood changes make the different SoCs in mach-mvebu/ depend on
> > MULTI_V7 or MULTI_V5 as appropriate.
> > 
> > We add this dependency to the new SoCs so that when the branches are
> > merged, everything is as it should be.
> > 
> > Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> 
> Acked-by: Andrew Lunn <andrew@lunn.ch>

Added and pushed.

thx,

Jason.

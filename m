From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 27 Nov 2012 16:02:30 -0500
Subject: [PATCH v3 2/4] ARM: kirkwood: DT board setup for Network Space
 v2 and parents
In-Reply-To: <50B52934.4090705@mpl.ch>
References: <1350468546-25901-1-git-send-email-simon.guinot@sequanux.org>
 <1350468546-25901-3-git-send-email-simon.guinot@sequanux.org>
 <20121126090253.GI9580@quad.lixom.net>
 <20121126151811.GF8628@kw.sim.vm.gnt>
 <20121126160449.GD15800@titan.lakedaemon.net>
 <20121127111454.GG8628@kw.sim.vm.gnt> <50B52934.4090705@mpl.ch>
Message-ID: <20121127210230.GN15800@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 09:57:24PM +0100, Stefan Peter wrote:
> Are there any plans to convert the existing non-DT kirkwood boards in
> 3.9, too?

Yes, that's on the list.  We were waiting for most of the drivers to be
converted to DT first.  Like the Dockstar, we'll leave the legacy setup
file around for a few releases, then probably deprecate them.

thx,

Jason. 

From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Jan 2013 11:39:09 -0500
Subject: [PATCH] ARM: Kirkwood: convert ns2 boards to pinctrl
In-Reply-To: <20130108163015.GF3392@lunn.ch>
References: <1357655778-32066-1-git-send-email-simon.guinot@sequanux.org>
 <20130108161553.GE3392@lunn.ch>
 <20130108161835.GN1357@kw.sim.vm.gnt>
 <20130108163015.GF3392@lunn.ch>
Message-ID: <20130108163909.GU5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 05:30:15PM +0100, Andrew Lunn wrote:
> > Do you think it is still possible to merge this patch as a bug fix for
> > the current release ?
> 
> Hi Simon
> 
> The commit log will need some explanation why this is a fix. It
> currently looks like it just a conversion. Document what actually goes
> wrong and how this fixes it.

hmm, I could change the patch subject to:

-ARM: Kirkwood: convert ns2 boards to pinctrl
+ARM: Kirkwood: fix gpio by converting ns2 boards to pinctrl

That's basically what the body says.  Sound good?

thx,

Jason.

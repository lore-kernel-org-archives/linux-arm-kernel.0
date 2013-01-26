From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 26 Jan 2013 18:04:59 -0500
Subject: [PATCH v2 0/3] Kirkwoode cpufreq driver
In-Reply-To: <3759655.fLV8aUUe7v@vostro.rjw.lan>
References: <1359215039-2848-1-git-send-email-andrew@lunn.ch>
 <3759655.fLV8aUUe7v@vostro.rjw.lan>
Message-ID: <20130126230459.GU1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 10:52:42PM +0100, Rafael J. Wysocki wrote:
> On Saturday, January 26, 2013 04:43:56 PM Andrew Lunn wrote:
> > This patchset adds a cpufreq driver for Marvell Kirkwood SoCs.
> > 
> > The changes to kirkwood_defconfig enable it and set the default
> > governor to ondemand.
> > 
> > Changes since v1:
> > 
> > tabify Kconfig.arm entry
> > Sort order of include files
> > Remove some unnecassary include files
> > Reformat multiline comment to be coding style conform.
> > 
> > Andrew Lunn (3):
> >   cpufreq: kirkwood: Add a cpufreq driver for Marvell Kirkwood SoCs
> >   arm: kirkwood: Instantiate cpufreq driver
> >   arm: kirkwood: Enable cpufreq and ondemand on kirkwood_defconfig
> 
> If you want me to take this, it'll need some ACKs from the clk people
> and arm-soc maintainers at least.

In the past, we've sent the driver changes (patch #1) through the
appropriate driver maintainer's tree, and the subsequent patches (2 & 3)
through arm-soc with a listed dependency on the driver maintainer's
tree/branch.  We've found that causes the fewest conflicts/headaches
that way.

If you're Ok with that, just let me know which tree and branch you pull
it in to.

> An ACK from Viresh would be welcome too.

fwiw:

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

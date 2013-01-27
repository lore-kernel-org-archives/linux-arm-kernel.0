From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sun, 27 Jan 2013 23:39 +0100
Subject: [PATCH v2 0/3] Kirkwoode cpufreq driver
In-Reply-To: <20130126230459.GU1758@titan.lakedaemon.net>
References: <1359215039-2848-1-git-send-email-andrew@lunn.ch>
 <3759655.fLV8aUUe7v@vostro.rjw.lan>
 <20130126230459.GU1758@titan.lakedaemon.net>
Message-ID: <4295673.nKKrtgdar0@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, January 26, 2013 06:04:59 PM Jason Cooper wrote:
> On Sat, Jan 26, 2013 at 10:52:42PM +0100, Rafael J. Wysocki wrote:
> > On Saturday, January 26, 2013 04:43:56 PM Andrew Lunn wrote:
> > > This patchset adds a cpufreq driver for Marvell Kirkwood SoCs.
> > > 
> > > The changes to kirkwood_defconfig enable it and set the default
> > > governor to ondemand.
> > > 
> > > Changes since v1:
> > > 
> > > tabify Kconfig.arm entry
> > > Sort order of include files
> > > Remove some unnecassary include files
> > > Reformat multiline comment to be coding style conform.
> > > 
> > > Andrew Lunn (3):
> > >   cpufreq: kirkwood: Add a cpufreq driver for Marvell Kirkwood SoCs
> > >   arm: kirkwood: Instantiate cpufreq driver
> > >   arm: kirkwood: Enable cpufreq and ondemand on kirkwood_defconfig
> > 
> > If you want me to take this, it'll need some ACKs from the clk people
> > and arm-soc maintainers at least.
> 
> In the past, we've sent the driver changes (patch #1) through the
> appropriate driver maintainer's tree, and the subsequent patches (2 & 3)
> through arm-soc with a listed dependency on the driver maintainer's
> tree/branch.  We've found that causes the fewest conflicts/headaches
> that way.
> 
> If you're Ok with that, just let me know which tree and branch you pull
> it in to.

Yes, that would be fine by me.  In the future, though, please say in the
comment part of the changelog (i.e. between the sign-off tag and the actual
patch) who's the target maintainer of the patch.

When patch [1/3] is ready, it will be applied to the pm-cpufreq branch of the
linux-pm.git tree (that branch doesn't contain any new material at the
moment, because I'm having issues with one of the candidate commits and
I'm debugging them).

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 May 2012 14:51:52 +0200
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <4FB23B9F.6040708@codethink.co.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB23B9F.6040708@codethink.co.uk>
Message-ID: <20120515145152.01d433c5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 15 May 2012 12:18:55 +0100,
Ben Dooks <ben.dooks@codethink.co.uk> a ?crit :

> > The patch set is based on your arm-soc/for-next branch.
> 
> Is there a git tree that can be pulled from?

Yes: https://github.com/Marvell-Semi/EBU_mainline_public/tree/for-next.

Note that of course we will be constantly rebasing this branch.

> > We intend to quickly build on top of this initial support with the
> > following elements:
> >
> >   * Usage of the clock framework
> 
> I'd say that was a pretty important part even if it just a couple of
> static clocks for the tclk and fabric clock.

As Lior said, it's on the TODO-list. It's true that adding the few
static clocks to tclk and the fabric clock can probably be done in this
initial submission, as the amount of work needed is fairly small.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

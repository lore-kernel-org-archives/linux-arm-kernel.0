From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Apr 2014 19:11:03 +0100
Subject: [PATCH v3 0/3] ARM: OMAP2+: AM437x: L2 cache support
In-Reply-To: <5356B2FB.5090205@ti.com>
References: <cover.1398149526.git.nsekhar@ti.com> <5356B2FB.5090205@ti.com>
Message-ID: <20140423181103.GO27282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 02:20:43PM -0400, Santosh Shilimkar wrote:
> On Tuesday 22 April 2014 04:28 AM, Sekhar Nori wrote:
> > This patch series adds L2 cache support for AM437x
> > and does some clean-ups for existing OMAP4 support
> > along the way (no functional changes). On OMAP4 Panda,
> > the Aux control value remains 0x7e470000 before and
> > after the series.
> > 
> > Tested on OMAP4 Panda and AM437x EPOS EVMs.
> > 
> > It is based on RMK's 75 patch series titled "l2c series" +
> > the patch contained in https://www.mail-archive.com/linux-omap at vger.kernel.org/msg103439.html
> > 
> > Sekhar Nori (3):
> >   ARM: OMAP2+: L2 cache: get rid of init call
> >   ARM: OMAP2+: L2 cache: git rid of redundant cache replacement policy
> >     setting
> >   ARM: OMAP2+: AM43x: L2 cache support
> > 
> For the whole series,
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Okay, as these depend on my series, I'll take them into my l2c branch,
which I'll be pushing into linux-next from this evening.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Feb 2014 15:18:21 +0000
Subject: [PATCH RFC v2 00/35] Second preview of imx-drm cleanup series
In-Reply-To: <1392045139.6687.31.camel@pizza.hi.pengutronix.de>
References: <20140210122802.GS26684@n2100.arm.linux.org.uk>
 <1392045139.6687.31.camel@pizza.hi.pengutronix.de>
Message-ID: <20140210151821.GY26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 04:12:19PM +0100, Philipp Zabel wrote:
> Am Montag, den 10.02.2014, 12:28 +0000 schrieb Russell King - ARM Linux:
> > This is the latest revision of my series cleaning up imx-drm and
> > hopefully getting it ready to be moved out of drivers/staging.
> > This series is updated to v3.14-rc2.
> > 
> > Since the last round of patches were posted, the component support
> > has been merged into mainline, and thus dropped from this series.
> > Greg has taken the first three patches and merged them into his
> > linux-next tree - however, I include them here for completness.
> > 
> > Most of the comments from last time still apply, and I'll look at
> > incorporating some of the other patches that were posted in the
> > coming week.
> > 
> > If I can have some acks for this, I'll start sending some of it to
> >
> >
> > Greg - I'd like to at least get the five or six initial imx-hdmi
> > patches to Greg and queued up for the next merge window sooner
> > rather than later, preferably getting most of this ready for that
> > window too.
> 
> For the first 9 patches up to (including) "imx-drm: ipu-v3: more
> clocking fixes":
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> As you say, comments about the device tree bindings still apply.
> I'd prefer if the patches that currently use the crtcs property were
> reworked to use the v4l2 style device tree bindings before they hit
> mainline.

I'm trying /not/ to do that much more work on this because there's
other things that need my attention, like a complete rewrite of the
SDHCI mess.  I want to get the imx-drm stuff off my plate so I don't
have to worry about it.

So, I'd really like _all_ these patches to go into mainline for v3.15
with the least rework possible so I can spend the next few months
working on rewriting SDHCI.

What I don't want is carrying hundreds of patches across multiple
kernel versions.

Now, mind explaining what "v4l2 style device tree bindings" means?  I've
no idea since I'm relatively new to DT.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".

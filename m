From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 10 Feb 2014 16:12:19 +0100
Subject: [PATCH RFC v2 00/35] Second preview of imx-drm cleanup series
In-Reply-To: <20140210122802.GS26684@n2100.arm.linux.org.uk>
References: <20140210122802.GS26684@n2100.arm.linux.org.uk>
Message-ID: <1392045139.6687.31.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 10.02.2014, 12:28 +0000 schrieb Russell King - ARM Linux:
> This is the latest revision of my series cleaning up imx-drm and
> hopefully getting it ready to be moved out of drivers/staging.
> This series is updated to v3.14-rc2.
> 
> Since the last round of patches were posted, the component support
> has been merged into mainline, and thus dropped from this series.
> Greg has taken the first three patches and merged them into his
> linux-next tree - however, I include them here for completness.
> 
> Most of the comments from last time still apply, and I'll look at
> incorporating some of the other patches that were posted in the
> coming week.
> 
> If I can have some acks for this, I'll start sending some of it to
>
>
> Greg - I'd like to at least get the five or six initial imx-hdmi
> patches to Greg and queued up for the next merge window sooner
> rather than later, preferably getting most of this ready for that
> window too.

For the first 9 patches up to (including) "imx-drm: ipu-v3: more
clocking fixes":
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

As you say, comments about the device tree bindings still apply.
I'd prefer if the patches that currently use the crtcs property were
reworked to use the v4l2 style device tree bindings before they hit
mainline.

regards
Philipp

From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 17 Aug 2011 08:48:54 +0200
Subject: [PATCH v3 1/3] ARM: i.MX51: Remove _MX51_PAD_xxx references
In-Reply-To: <4E4AC27A.9030608@boundarydevices.com>
References: <1313265101-11478-1-git-send-email-troy.kisky@boundarydevices.com>
	<20110816072603.GW31404@pengutronix.de>
	<4E4AC27A.9030608@boundarydevices.com>
Message-ID: <20110817064854.GD31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 12:18:18PM -0700, Troy Kisky wrote:
> On 8/16/2011 12:26 AM, Sascha Hauer wrote:
> > On Sat, Aug 13, 2011 at 12:51:41PM -0700, Troy Kisky wrote:
> >> Use new macro NEW_PAD_CTRL to remove _MX51_PAD_xxx references.
> >> A later patch will remove the _MX51_PAD_xxx symbols.
> >>
> >> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> >> ---
> >>  arch/arm/mach-mx5/board-cpuimx51sd.c         |    2 +-
> >>  arch/arm/mach-mx5/board-mx51_babbage.c       |    4 ++--
> >>  arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c |    4 ++--
> >>  arch/arm/plat-mxc/include/mach/iomux-v3.h    |    1 +
> >>  4 files changed, 6 insertions(+), 5 deletions(-)
> >>
> >>
> >> Changes since v2: add () around cfg in NEW_PAD_CTRL macro
> >> as noticed by Sascha.
> >>
> >> 2/3 and 3/3 are the same as v2 and are not reposted.
> > 
> > Applied this one. Can you send me the whole 2/3 and 3/3 patches?
> > I only have the sed scripts which I don't want to execute manually.
> > 
> > Sascha
> > 
> I'll send you the patch against mainline.
> if you want it against a different branch, let me know.

Mainline is fine. Applied them for cleanups.

Thanks
 Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

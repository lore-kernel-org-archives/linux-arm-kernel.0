From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jan 2014 15:16:39 +0000
Subject: [PATCH 1/9] ARM: dts: imx6qdl: remove the use of pingrp macros
In-Reply-To: <20140127150509.GD4765@S2101-09.ap.freescale.net>
References: <1390668191-20289-1-git-send-email-shawn.guo@linaro.org>
 <1390668191-20289-2-git-send-email-shawn.guo@linaro.org>
 <20140127143745.GM15937@n2100.arm.linux.org.uk>
 <20140127150509.GD4765@S2101-09.ap.freescale.net>
Message-ID: <20140127151638.GN15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 11:05:11PM +0800, Shawn Guo wrote:
> On Mon, Jan 27, 2014 at 02:37:45PM +0000, Russell King - ARM Linux wrote:
> > On Sun, Jan 26, 2014 at 12:43:03AM +0800, Shawn Guo wrote:
> > >  arch/arm/boot/dts/imx6dl-hummingboard.dts  |    5 +-
> > >  arch/arm/boot/dts/imx6qdl-microsom.dtsi    |    5 +-
> > 
> > I've merged your changes here into my local copy of these just to reduce
> > the conflicts - unfortunately, it's taken soo long to deal with the above
> > that the cubox-i has now been released, which has prompted some
> > reorganisation between the above two files.
> > 
> > I would much rather you dropped these two entirely, and let me push them
> > upstream, rather than having some nasty conflicts which result from this.
> 
> So you're basically asking me to drop patch [1] from imx/dt branch (tag
> imx-dt-3.14), which I have sent to Olof for 3.14 inclusion.  Yes, I
> still hope Olof can pull it with this turn-around series applied on top.
> So please let's wait for Olof's word to see if we can make it.  If it's
> still a NO for some reason, I will be certainly fine with you pushing
> hummingboard stuff upstream, and will drop it from my tree.

My point is that the DT files I _now_ have are quite different in
organisation to the ones I submitted to you, so there's going to be
conflicts if your version goes in.

Moreover, I don't want the old ones in 3.14 as-is, because I don't want
declarations which should not have been in the microsom file but in the
hummingboard file being in a final release of the mainline kernel.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".

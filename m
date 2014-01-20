From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jan 2014 00:44:34 +0000
Subject: [PATCH 0/2] DT updates for Hummingboard and new Cubox-i
In-Reply-To: <20140119185246.GB28056@quad.lixom.net>
References: <20140116182211.GX15937@n2100.arm.linux.org.uk>
 <20140119031816.GD16158@S2101-09.ap.freescale.net>
 <20140119185246.GB28056@quad.lixom.net>
Message-ID: <20140120004434.GV15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 10:52:46AM -0800, Olof Johansson wrote:
> On Sun, Jan 19, 2014 at 11:18:18AM +0800, Shawn Guo wrote:
> > On Thu, Jan 16, 2014 at 06:22:12PM +0000, Russell King - ARM Linux wrote:
> > > Now that the Cubox-i has been released, and I have one, I've been able to
> > > update things a little.  Out of the following two patches, the first one
> > > I think is critical to be merged before the microsom support hits
> > > mainline, since it drops the flexcan support from the microsom level,
> > > moving it to the Hummingboard level.
> > 
> > I will be out of town for a few days, and won't be online until next
> > weekend.  So please send the patch directly to arm-soc folks, so that
> > they can send it together with imx-dt-3.14 stuff.
> > 
> > arm-soc folks, please take this as another ping for my imx-dt-3.14 pull
> > request :)
> 
> I'm well aware that the DT branch has not been merged, and that's because
> there has been no consensus from DT maintainers on the massive rework
> you did as the base of the branch.
> 
> Given the timing, it's not looking like it will be resolved in time for
> the 3.14 merge window (which might open today).

Okay, that presumably means that the Hummingboard stuff won't be going in
through this route, and it sounds like the imx DT stuff will need rework.

Is there any objection if I pushed just the Hummingboard files upstream
myself?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".

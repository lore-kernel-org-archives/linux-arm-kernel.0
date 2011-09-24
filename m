From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 24 Sep 2011 00:31:45 -0600 (MDT)
Subject: [PATCH 0/8] OMAP3/4: Misc fixes and clean-up
In-Reply-To: <4E7D72BF.8060009@ti.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
	<4E7D72BF.8060009@ti.com>
Message-ID: <alpine.DEB.2.00.1109240031280.22872@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh

On Sat, 24 Sep 2011, Santosh Shilimkar wrote:

> On Thursday 08 September 2011 10:51 AM, Santosh Shilimkar wrote:
> > The series contains few fixes and clean-up for OMAP.
> > Briefly,
> > - HWMOD fix for the address space count
> > - Improving the L3 register accesses
> > - Bug fix in the L3 error handler
> > - Sparce warning and indentation fixes in L3 error handler
> > - Print master id in case of L3 custom errors for better debug.
> > - Adding local time clock node for the CPUfreq and time re-calibration
> > - Fix in the address overlap for emif and emulation domain.
> > 
> > The series is tested on OMAP4430 SDP and OMAP4430 beagle and SDP.
> > 
> > The following changes since commit c6a389f123b9f68d605bb7e0f9b32ec1e3e14132:
> > 
> >   Linux 3.1-rc4 (2011-08-28 21:16:01 -0700)
> > 
> > are available in the git repository at:
> >   git://gitorious.org/omap-sw-develoment/linux-omap-dev.git v3.1-rc4-omap-misc
> >
> I need your ack on below two patches so that I can re-base them and
> send a pull request to Tony.
> 
> OMAP4: clock: Add CPU local timer clock node.
> OMAP: Fix sparse warnings in l3 error handler.

Are you targeting these for 3.1-rc ?


- Paul

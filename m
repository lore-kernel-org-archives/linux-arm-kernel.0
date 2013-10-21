From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 21 Oct 2013 20:36:55 +0800
Subject: imx-drm: Add HDMI support
In-Reply-To: <20131021093448.GX25034@n2100.arm.linux.org.uk>
References: <52602EEA.6060402@prisktech.co.nz>
 <20131017193948.GT25034@n2100.arm.linux.org.uk>
 <1382039535.976669051@f130.i.mail.ru>
 <20131017203545.GV25034@n2100.arm.linux.org.uk>
 <20131019121218.GH25034@n2100.arm.linux.org.uk>
 <20131021091259.GB9716@S2101-09.ap.freescale.net>
 <20131021093448.GX25034@n2100.arm.linux.org.uk>
Message-ID: <20131021123652.GN17165@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 10:34:48AM +0100, Russell King - ARM Linux wrote:
> However, the IPU is more stable with switching to bypass while it relocks
> than not.

As far as I know, FSL kernel has always been doing relock without
switching to bypass, and I haven't heard unstable IPU issue from their
testing.  Do you have a case that I can set up here to see the issue?

Shawn

> > > Here's a diff which updates the av PLL to do this:
> > 
> > Some other PLLs needs update too.  I will cook up patches to fix these
> > problems.
> 
> Yes, I only changed the set_rate on the AV codecs as I haven't tested
> that on the others.

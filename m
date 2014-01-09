From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Jan 2014 13:17:32 +0000
Subject: [PATCH RFC 00/46] Preview of imx-drm cleanup series
In-Reply-To: <20140107063319.GA12346@S2101-09.ap.freescale.net>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <20140107063319.GA12346@S2101-09.ap.freescale.net>
Message-ID: <20140109131732.GC27432@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 02:33:22PM +0800, Shawn Guo wrote:
> On Thu, Jan 02, 2014 at 09:25:28PM +0000, Russell King - ARM Linux wrote:
> > Here is my large patch series which cleans up imx-drm, and gets it ready
> > to move out of drivers/staging.  This is a preview only.
> 
> When moving to non-RFC patches, you may want to run checkpatch.pl on the
> patches.  There are some errors and warnings than just "line over 80
> characters" one.

I'm going to fix some of them, but I'm not fixing all of them.  The
reason is that some of these should have been done to the code already,
and I'm not going to mess up my patches integrating coding style fixes
amongst moving code around.

The warnings about "over 80 characters" are fine for new code but not
when code is merely being moved - there it's far more important not to
reformat code.

The errors you refer to are:
(a) in Fabio's patch adding imx-hdmi support, a derivative of which has
    already been accepted into the staging tree.
(b) in ipuv3-crtc.c, where checkpatch detects the presence of the FSF
    address in the context of my patch.

So, these are not my problem to fix, and I will *not* fix these "errors"
in this series.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".

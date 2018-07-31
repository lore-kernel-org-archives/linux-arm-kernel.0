From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jul 2018 08:41:15 +0100
Subject: [PATCH v2 0/7] tda998x: allow use with bridge based devices
In-Reply-To: <73adc630-21cd-5b14-cb47-f1a58ee3bc83@axentia.se>
References: <20180730164137.GD17271@n2100.armlinux.org.uk>
 <73adc630-21cd-5b14-cb47-f1a58ee3bc83@axentia.se>
Message-ID: <20180731074114.GF17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 07:44:24AM +0200, Peter Rosin wrote:
> On 2018-07-30 18:41, Russell King - ARM Linux wrote:
> > Hi,
> > 
> > This is a re-posting of the series I responded to Peter Rosin's May
> > posting, with a few bugs fixed, and the bridge registered outside of
> > the component helper.  This should allow Peter to use the driver
> > while maintaining armada drm and tilcdc support.
> > 
> > No comments (other than 0-day test results) were received on the
> > previous posting.
> 
> I of course meant to comment on this! I didn't because there was a rush
> before vacation, then vacation, then a heap of important stuff that had
> piled up. This one simply had too low priority to make a significant bleep
> on the radar. Sorry for the silence...
> 
> However, now that I do try to test, I get conflicts as I try to apply the
> patches. I'm wondering what this was based on? I've tried next-20180730
> drm-misc/drm-misc-next from some minutes ago.

They're based on 4.17.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up

From: peda@axentia.se (Peter Rosin)
Date: Tue, 31 Jul 2018 07:44:24 +0200
Subject: [PATCH v2 0/7] tda998x: allow use with bridge based devices
In-Reply-To: <20180730164137.GD17271@n2100.armlinux.org.uk>
References: <20180730164137.GD17271@n2100.armlinux.org.uk>
Message-ID: <73adc630-21cd-5b14-cb47-f1a58ee3bc83@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-07-30 18:41, Russell King - ARM Linux wrote:
> Hi,
> 
> This is a re-posting of the series I responded to Peter Rosin's May
> posting, with a few bugs fixed, and the bridge registered outside of
> the component helper.  This should allow Peter to use the driver
> while maintaining armada drm and tilcdc support.
> 
> No comments (other than 0-day test results) were received on the
> previous posting.

I of course meant to comment on this! I didn't because there was a rush
before vacation, then vacation, then a heap of important stuff that had
piled up. This one simply had too low priority to make a significant bleep
on the radar. Sorry for the silence...

However, now that I do try to test, I get conflicts as I try to apply the
patches. I'm wondering what this was based on? I've tried next-20180730
drm-misc/drm-misc-next from some minutes ago.

Cheers,
Peter

> 
> This is independent of the component helper vs bridge safety issues.
> 
>  drivers/gpu/drm/i2c/tda998x_drv.c | 288 ++++++++++++++++++++------------------
>  1 file changed, 151 insertions(+), 137 deletions(-)
> 

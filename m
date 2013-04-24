From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 24 Apr 2013 11:00:02 +0200
Subject: [PATCH 0/2] drivers/video: mxs-fb: build fixes
In-Reply-To: <1366790894-20426-1-git-send-email-mpa@pengutronix.de>
References: <1366790894-20426-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20130424090002.GB3973@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 10:08:12AM +0200, Markus Pargmann wrote:
> Hi,
> 
> mxs-fb commit
> 
> 669406534b4abb827d1bdc39bb5e2d5255818ae2 video: mxsfb: get display timings from device tree
> 
> creates a build failure together with those commits:
> 
> a38884f681a4d044befd30d9f3d19a0821bae63a videomode: simplify videomode Kconfig and Makefile
> 6cd2c7db41eab204b6474534df4ca68a7dc53d86 videomode: videomode_from_timing work
> 
> All of them are in linux-next, so mxs-fb fails to build there.
> 
> Regards,
> 
> Markus
> 
> 
> 

Sorry for the noise. This was already fixed and queued for 3.10-rc.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

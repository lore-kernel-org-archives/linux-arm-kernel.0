From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 5 Nov 2009 08:29:07 +0100
Subject: [PATCH 0/6] mx31moboard: patches for next merge window v2
In-Reply-To: <1257268191-19075-1-git-send-email-valentin.longchamp@epfl.ch>
References: <1257268191-19075-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <20091105072907.GL30179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Valentin,

On Tue, Nov 03, 2009 at 06:09:45PM +0100, Valentin Longchamp wrote:
> Here are the patches I would like to push during the next merge window for
> the mx31moboard platform.
> 
> It consists of a fix for a small hardware design issue for the main serial
> port, a few GPIOs used on the robots that are declared, camera support and
> finally MC13783 support as it is now getting ready.
> 
> For MC13783, we need RTC as well, but it was not tested yet since it is not
> in mainline yet.
> 
> The camera part works for one camera. The soc_camera needs some reworking
> before we are able to support the two cameras we have on the robot
> 
> The main peripheral that we are using and that still is missing is the USB
> host, but since the driver still needs a few improvements, I keep it aside
> for now.
> 
> Changes since v1:
> - changed the patches order
> - support for a single camera
> - corrected typos and comments from earlier version

ok, applied to mxc-master.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

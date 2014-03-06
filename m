From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Thu, 6 Mar 2014 20:26:17 +0100
Subject: mx6q csi driver ?
In-Reply-To: <20140305223753.GA28522@frolo.macqel>
References: <20140305223753.GA28522@frolo.macqel>
Message-ID: <20140306192617.GK24339@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 05, 2014 at 11:37:53PM +0100, Philippe De Muyter wrote:
> I try to write a linux driver for a cmos sensor connected to a sabresd
> board, but I wonder where to continue.
> 
> I first considered using the freescale 3.10.17 beta kernel,
> which has already a csi v4l2 driver (but using deprecated v4l2 internals).

We already have patches for the CSI, for 3.14-rc+ and based on all the
latest and greatest v4l2 stuff.

Before posting those, we'd like to get the current move-ipu-out-of-
staging effort patch series resolved, then the video part will be one of
the next topics we'll address.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

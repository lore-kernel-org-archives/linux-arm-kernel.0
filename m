From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Tue, 16 Dec 2014 20:19:18 +0100
Subject: How much flash space should I reserve for device tree blobs?
In-Reply-To: <CAFZh4h_74LY=w7gV=zNAC0ssRFgrh1DduPmZ2c+HenbztRRc-A@mail.gmail.com>
References: <CAFZh4h_74LY=w7gV=zNAC0ssRFgrh1DduPmZ2c+HenbztRRc-A@mail.gmail.com>
Message-ID: <20141216191918.GM1884@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 03:33:50PM -0500, Brian Hutchinson wrote:
> Reflecting back on the famous quote of "Nobody needs more than 640K",
> how much space should I reserve in flash to 'future proof' my MTD map
> in regards to dtb's?
> 
> Looking at the current flavors of dtb's built in a recent mainline
> kernel, the biggest one I see is 66K.
> 
> How big do you all see these getting?  I know, it's probably a loaded
> question.  Would just like to bounce this off the list as a sanity
> check ... measure twice cut once kind of thing.

With barebox, we put the devicetree into the root filesystem and search
it via an freedesktop.org bootspec entry these days.

rsc 
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

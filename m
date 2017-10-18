From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Oct 2017 13:42:19 +0200
Subject: [PATCH 1/6] phy: sun4i-usb: add support for R40 USB PHY
In-Reply-To: <46407134-3d1f-0132-f692-1536dcc47980@ti.com>
References: <20171008042906.46779-1-icenowy@aosc.io>
 <20171008042906.46779-2-icenowy@aosc.io>
 <20171009205839.432f6jd5zhmstwp3@flea.home>
 <46407134-3d1f-0132-f692-1536dcc47980@ti.com>
Message-ID: <20171018114219.lykghmhzve5yvhaa@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 05:09:00PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Tuesday 10 October 2017 02:28 AM, Maxime Ripard wrote:
> > On Sun, Oct 08, 2017 at 04:29:01AM +0000, Icenowy Zheng wrote:
> >> Allwinner R40 features a USB PHY like the one in A64, but with 3 PHYs.
> >>
> >> Add support for it.
> >>
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > 
> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Is this patch good to be merged? I see you have pending comments on the other
> patch in the series.

Yeah, but I guess you can merge this one, it's pretty harmless, and it
will reduce the amount of patches to review / merge later on.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171018/af90732f/attachment.sig>

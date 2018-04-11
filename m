From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 11 Apr 2018 09:48:08 +0200
Subject: [linux-sunxi] [PATCH v3] ARM: sun8i: v40: enable USB host ports
 for Banana Pi M2 Berry
In-Reply-To: <CAGb2v651vpy3jdFY56CQi4yBU1wh01ecPn9cO9fiXkfed35QDA@mail.gmail.com>
References: <20180406140344.9457-1-icenowy@aosc.io>
 <CAGb2v651vpy3jdFY56CQi4yBU1wh01ecPn9cO9fiXkfed35QDA@mail.gmail.com>
Message-ID: <20180411074808.eogpgm3xtercmnay@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2018 at 03:33:34PM +0800, Chen-Yu Tsai wrote:
> On Fri, Apr 6, 2018 at 10:03 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> > Banana Pi M2 Berry has an on-board USB Hub that provides 4 USB Type-A
> > ports, and it's connected to the USB1 port of the SoC.
> >
> > Enable it.
> >
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> 
> Verified against public schematics.
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Applied for 4.18

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180411/3a74464f/attachment-0001.sig>

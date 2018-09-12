From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 12 Sep 2018 09:23:47 +0200
Subject: [PATCH v9 5/9] media: platform: Add Cedrus VPU decoder driver
In-Reply-To: <20180911124625.6759e429@coco.lan>
References: <20180906222442.14825-1-contact@paulk.fr>
 <20180906222442.14825-6-contact@paulk.fr>
 <20180911124625.6759e429@coco.lan>
Message-ID: <20180912072347.nqw4uu23fykjtz72@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 12:46:25PM -0300, Mauro Carvalho Chehab wrote:
> Em Fri,  7 Sep 2018 00:24:38 +0200
> Paul Kocialkowski <contact@paulk.fr> escreveu:
> 
> > From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > 
> > This introduces the Cedrus VPU driver that supports the VPU found in
> > Allwinner SoCs, also known as Video Engine. It is implemented through
> > a V4L2 M2M decoder device and a media device (used for media requests).
> > So far, it only supports MPEG-2 decoding.
> > 
> > Since this VPU is stateless, synchronization with media requests is
> > required in order to ensure consistency between frame headers that
> > contain metadata about the frame to process and the raw slice data that
> > is used to generate the frame.
> > 
> > This driver was made possible thanks to the long-standing effort
> > carried out by the linux-sunxi community in the interest of reverse
> > engineering, documenting and implementing support for the Allwinner VPU.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> There are several checkpatch issues here. Ok, some can be
> ignored, but there are at least some of them that sounda relevant.

Sorry for that. Given that it's intended to be in staging, do you want
us to send subsequent patches or the whole serie?

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180912/0416e9f3/attachment.sig>

From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 11 Sep 2018 10:53:55 +0200
Subject: [PATCH v9 0/9] Cedrus driver for the Allwinner Video Engine,
 using media requests
In-Reply-To: <20180906222442.14825-1-contact@paulk.fr>
References: <20180906222442.14825-1-contact@paulk.fr>
Message-ID: <20180911085355.bmd6gm24tkuxzdst@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2018 at 12:24:33AM +0200, Paul Kocialkowski wrote:
> This is the ninth iteration of the updated Cedrus driver,
> that supports the Video Engine found on most Allwinner SoCs, starting
> with the A10. It was tested on the A13, A20, A33 and H3.
> 
> The initial version of this driver[0] was originally written and
> submitted by Florent Revest using a previous version of the request API
> that is necessary to provide coherency between controls and the buffers
> they apply to.
> 
> The driver was adapted to use the latest version of the media request
> API[1], as submitted by Hans Verkuil. Media request API support is a
> hard requirement for the Cedrus driver.
> 
> The driver itself currently only supports MPEG2 and more codecs will be
> added eventually. The default output frame format provided by the Video
> Engine is a multi-planar tiled YUV format (based on NV12). A specific
> format is introduced in the V4L2 API to describe it. Starting with the
> A33, the Video Engine can also output untiled YUV formats.

Applied the DTS patches, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180911/d1ae15e4/attachment.sig>

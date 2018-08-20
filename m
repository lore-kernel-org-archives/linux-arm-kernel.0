From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 20 Aug 2018 16:46:57 +0200
Subject: [PATCH] arm64: allwinner: dts: h6: fix Pine H64 MMC bus width
In-Reply-To: <6e2df3d919b85f48c22c653124b7c2b594cb2d28.camel@aosc.io>
References: <20180726044805.55888-1-icenowy@aosc.io>
 <20180730082712.koiaej6dxjnnk6lb@flea>
 <6e2df3d919b85f48c22c653124b7c2b594cb2d28.camel@aosc.io>
Message-ID: <20180820144657.pexeoupw5h5xwcc5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2018 at 10:24:20PM +0800, Icenowy Zheng wrote:
> ? 2018-07-30?? 10:27 +0200?Maxime Ripard???
> > On Thu, Jul 26, 2018 at 12:48:05PM +0800, Icenowy Zheng wrote:
> > > Currently the enabled MMC controllers on Pine H64 do not have bus-
> > > width
> > > set, which make them fall back to 1-bit mode and become quite slow.
> > > 
> > > Fix this by add the corresponding bus-width properties.
> > > 
> > > Fixes: ecbd611882a1 ("arm64: allwinner: h6: enable MMC0/2 on Pine
> > > H64")
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > 
> > Applied, thanks!
> 
> BTW why didn't I see it in next-20180820?
> 
> It's 3 weeks later, and you didn't say that the patch is queued for
> another version.

This has been merged to a fix branch we'll send for 4.19 once rc1 is
out.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180820/2f13b50d/attachment.sig>

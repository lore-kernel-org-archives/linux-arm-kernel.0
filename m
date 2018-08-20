From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 20 Aug 2018 22:24:20 +0800
Subject: [PATCH] arm64: allwinner: dts: h6: fix Pine H64 MMC bus width
In-Reply-To: <20180730082712.koiaej6dxjnnk6lb@flea>
References: <20180726044805.55888-1-icenowy@aosc.io>
 <20180730082712.koiaej6dxjnnk6lb@flea>
Message-ID: <6e2df3d919b85f48c22c653124b7c2b594cb2d28.camel@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2018-07-30?? 10:27 +0200?Maxime Ripard???
> On Thu, Jul 26, 2018 at 12:48:05PM +0800, Icenowy Zheng wrote:
> > Currently the enabled MMC controllers on Pine H64 do not have bus-
> > width
> > set, which make them fall back to 1-bit mode and become quite slow.
> > 
> > Fix this by add the corresponding bus-width properties.
> > 
> > Fixes: ecbd611882a1 ("arm64: allwinner: h6: enable MMC0/2 on Pine
> > H64")
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> 
> Applied, thanks!

BTW why didn't I see it in next-20180820?

It's 3 weeks later, and you didn't say that the patch is queued for
another version.

> Maxime
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

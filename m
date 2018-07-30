From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 30 Jul 2018 10:27:12 +0200
Subject: [PATCH] arm64: allwinner: dts: h6: fix Pine H64 MMC bus width
In-Reply-To: <20180726044805.55888-1-icenowy@aosc.io>
References: <20180726044805.55888-1-icenowy@aosc.io>
Message-ID: <20180730082712.koiaej6dxjnnk6lb@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 12:48:05PM +0800, Icenowy Zheng wrote:
> Currently the enabled MMC controllers on Pine H64 do not have bus-width
> set, which make them fall back to 1-bit mode and become quite slow.
> 
> Fix this by add the corresponding bus-width properties.
> 
> Fixes: ecbd611882a1 ("arm64: allwinner: h6: enable MMC0/2 on Pine H64")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180730/78660ce4/attachment.sig>

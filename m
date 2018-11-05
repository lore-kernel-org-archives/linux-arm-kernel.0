From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 5 Nov 2018 10:43:41 +0100
Subject: [PATCH v3 00/28] Allwinner H6 DE3 and HDMI support
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
Message-ID: <20181105094341.qedt7jvnxooiojki@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 04, 2018 at 07:26:37PM +0100, Jernej Skrabec wrote:
> This series adds support for Display Engine 3.0 and HDMI 2.0a, which
> can be found on H6 SoC.
> 
> Display Engine 3.0 in comparison to 2.0 mostly adds features needed for
> displaying and processing 10-bit and AFBC formats, which are not yet
> supported by this series.
> 
> H6 is also the first SoC which supports IOMMU, but support for it is
> not yet added.
> 
> This series is based on linux-next at next-20181102.
> 
> I suggest all patches go through allwinner tree, except DRM patches,
> which should go through drm-misc tree.

Applied all patches up to the 26. The two last one however should not
use the clk bindings define you added in the first clk patches, since
clk and dt patches are going through different tree.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181105/abc08b44/attachment.sig>

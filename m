From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 16 Feb 2018 10:09:25 +0100
Subject: [PATCH v5 00/12] drm/sun4i: Add A83T HDMI support
In-Reply-To: <20180214200906.31509-1-jernej.skrabec@siol.net>
References: <20180214200906.31509-1-jernej.skrabec@siol.net>
Message-ID: <20180216090925.bct4u3rfdg4epmpa@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 09:08:54PM +0100, Jernej Skrabec wrote:
> This patch series implements support for A83T DW HDMI and PHY. Contrary to
> v1 series, this one is based on latest linux-next, since all needed patches
> were merged.
> 
> While exactly this combination of HDMI controller and PHY is not common in
> Allwinner SoCs, this patch series nevertheless makes groundwork for other
> SoCs, which have same DW HDMI IP block, but different PHYs, like H3 and H5.
> 
> Please take a look.

Applied and pushed everything, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180216/4681fb9e/attachment.sig>

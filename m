From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 7 Sep 2018 13:23:31 +0200
Subject: [PATCH v2 0/6] drm/sun4i: Support color dithering for LCD panels
In-Reply-To: <20180907041948.19913-1-wens@csie.org>
References: <20180907041948.19913-1-wens@csie.org>
Message-ID: <20180907112331.wjml25rfkyabvwwt@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2018 at 12:19:42PM +0800, Chen-Yu Tsai wrote:
> 
> Hi,
> 
> This is v2 of my sun4i-drm LCD color dithering series. v1 was from back
> in April [1]. Most of the driver code is unchanged.
> 
> Changes since v1:
> 
>   - Explicitly list properties from the simple-panel binding that apply
>     to the Bananapi 7" panel
> 
>   - Moved an incorrectly squashed change from patch 3 to patch 1, where
>     it belongs

Applied the first three patches, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180907/fe10f9e0/attachment.sig>

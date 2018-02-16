From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 16 Feb 2018 21:18:18 +0100
Subject: [PATCH] drm/sun4i: fix HSYNC and VSYNC polarity
In-Reply-To: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <20180216201818.j5gunpkkebq35b4n@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 06:54:48PM +0100, Giulio Benetti wrote:
> Differently from other Lcd signals, HSYNC and VSYNC signals
> result inverted if their bits are cleared to 0.
> 
> Invert their settings of IO_POL register.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180216/9c18b0cc/attachment.sig>

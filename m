From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 21 Mar 2018 12:28:28 +0100
Subject: [PATCH v2] clk: sunxi-ng: add missing hdmi-slow clock for H6 CCU
In-Reply-To: <20180321024625.18516-1-icenowy@aosc.io>
References: <20180321024625.18516-1-icenowy@aosc.io>
Message-ID: <20180321112828.6i3qdbes3no5gypd@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 10:46:25AM +0800, Icenowy Zheng wrote:
> The Allwinner H6 CCU has a "HDMI Slow Clock", which is currently missing
> in the ccu-sun50i-h6 driver.
> 
> Add this missing clock to the driver.
> 
> Fixes: 542353ea ("clk: sunxi-ng: add support for the Allwinner H6 CCU")
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180321/434373d9/attachment.sig>

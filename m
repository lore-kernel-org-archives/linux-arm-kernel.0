From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:28:00 +0100
Subject: [PATCH 13/15] ARM: dts: sun8i: r40: Add clock accuracy for
 external oscillators
In-Reply-To: <20181128093013.24442-15-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-15-wens@csie.org>
Message-ID: <20181128102800.sijdx26dded6mc2y@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 05:30:11PM +0800, Chen-Yu Tsai wrote:
> The R40 datasheet specifies a tolerance range for the external
> oscillators used. Add them to the device tree as the clock accuracy.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/58220061/attachment.sig>

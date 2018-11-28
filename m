From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:26:14 +0100
Subject: [PATCH 10/15] ARM: dts: sun8i: a23/a33: Fix up RTC device node
In-Reply-To: <20181128093013.24442-12-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-12-wens@csie.org>
Message-ID: <20181128102614.6s75wwceayz2zroj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 05:30:08PM +0800, Chen-Yu Tsai wrote:
> The RTC module on the A23 was claimed to be the same as on the A31, when
> in fact it is not. The A31 does not have an RTC external clock output,
> and its internal RC oscillator's average clock rate is not in the same
> range. The A33's RTC is the same as the A23.
> 
> This patch fixes the compatible string and clock properties to conform
> to the updated bindings. The register range is also fixed.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/08c1f64d/attachment.sig>

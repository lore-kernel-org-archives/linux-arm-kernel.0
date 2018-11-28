From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:19:06 +0100
Subject: [PATCH 02/15] dt-bindings: rtc: sun6i-rtc: Add compatible
 strings for pre-H6 variants
In-Reply-To: <20181128093013.24442-3-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-3-wens@csie.org>
Message-ID: <20181128101906.xkqaoezxodz25c3x@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 05:29:59PM +0800, Chen-Yu Tsai wrote:
> While doing Bluetooth enablement for various boards based on various
> Allwinner SoCs, minor differences in the RTC modules were found. These
> include a lack of an external clock output (A31), different internal
> oscillator frequencies (H3/H5/A64/V3/V3s), different regulator voltage
> settings (H5/H6), and the presence of miscellaneous registers unrelated
> to the RTC (A64/R40/H5/H6). The datasheet also describes different number
> of registers for non-volatile storage, though based on actual experiments
> the actual number is the same across the board.
> 
> This patch adds a list of all pre-H6 variants, grouped by the internal
> oscillator's clock rate, regulator settings, and the presence of the
> external clock output. Combinations are introduced for the variants that
> have miscellaneous registers.
> 
> The RTC block in the H6 also handles the 24 MHz DCXO. This will require
> more device tree binding changes and will be done later.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/c65eb865/attachment.sig>

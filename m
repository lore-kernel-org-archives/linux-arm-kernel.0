From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:28:44 +0100
Subject: [PATCH 15/15] arm64: dts: allwinner: a64: Fix up RTC device node
 and clock references
In-Reply-To: <20181128093013.24442-17-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-17-wens@csie.org>
Message-ID: <20181128102844.vkleeqmryyxs5s4i@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 05:30:13PM +0800, Chen-Yu Tsai wrote:
> The RTC module on the A64 was claimed to be the same as on the A31, when
> in fact it is not. It is actually compatible to the H3's RTC. The A64's
> RTC has some extra crypto-related registers which the H3's does not, but
> the exact function of these is not clear.
> 
> This patch fixes the compatible string and clock properties to conform
> to the updated bindings. The device node for the internal oscillator is
> removed, as it is internalized into the RTC device. Clock references to
> the IOSC and LOSC are also fixed.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/4cbde7a8/attachment-0001.sig>

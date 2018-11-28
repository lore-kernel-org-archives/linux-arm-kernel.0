From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:21:00 +0100
Subject: [PATCH 05/15] rtc: sun6i: Add default clock name for LOSC
In-Reply-To: <20181128093013.24442-6-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-6-wens@csie.org>
Message-ID: <20181128102100.h3qkvnpbazpy2lbk@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 05:30:02PM +0800, Chen-Yu Tsai wrote:
> The RTC's main clock, used internally and exported to the rest of the
> SoC, is called "LOSC" (low speed oscillator) through the hardware
> documentation.
> 
> This patch adds a default name for this clock, in case the device tree
> does not provide one. This shouldn't happen, but lets play it safe.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/8ba52197/attachment-0001.sig>

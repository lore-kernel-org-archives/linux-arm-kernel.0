From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:20:15 +0100
Subject: [PATCH 03/15] dt-bindings: rtc: sun6i-rtc: Deprecate external
 clock output for A31
In-Reply-To: <20181128093013.24442-4-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-4-wens@csie.org>
Message-ID: <20181128102015.jfzqgdlstkjmdfwl@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 05:30:00PM +0800, Chen-Yu Tsai wrote:
> The A31 does not have an external clock output directly from the RTC.
> Instead, it has four muxable clock outputs: three (A, B, C) are
> controlled from the CCU, and the last (D) is controlled from the PRCM.
> 
> Deprecate the usage of the external clock output for the A31 compatible.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

I guess we should add a warning in the code as well if one tries to
use it.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/b788e898/attachment.sig>

From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:28:17 +0100
Subject: [PATCH 14/15] ARM: dts: sun8i: r40: Add RTC device node
In-Reply-To: <20181128093013.24442-16-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-16-wens@csie.org>
Message-ID: <20181128102817.4xzxlvrxxstca6dj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 05:30:12PM +0800, Chen-Yu Tsai wrote:
> The R40 has an RTC hardware block, which has additional registers
> that are not related to RTC or clock functions, and is otherwise
> compatible with the H3's RTC.
> 
> Add a device node for it, and fix up any references to the LOSC.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/46e0c76c/attachment.sig>

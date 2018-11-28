From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:24:44 +0100
Subject: [PATCH 07/15] rtc: sun6i: Add support for all known pre-H6
 variants
In-Reply-To: <20181128093013.24442-8-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-8-wens@csie.org>
Message-ID: <20181128102444.3wxqa6wfv67jqh7k@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 05:30:04PM +0800, Chen-Yu Tsai wrote:
> There are different variants to the RTC hardware first seen on sun6i
> (A31). The differences we care about in this driver are the clock rate
> for the internal oscillator, prescalers, and the presence of an external
> clock output.
> 
> This patch adds support for all the known pre-H6 base compatibles using
> the variants data structure previously introduced.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/f8e52149/attachment.sig>

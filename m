From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Apr 2018 13:53:11 +0200
Subject: [PATCH 3/7] ARM: dts: sun8i: h2-plus: Sort dtb entries in Makefile
In-Reply-To: <20180424113424.13196-4-wens@csie.org>
References: <20180424113424.13196-1-wens@csie.org>
 <20180424113424.13196-4-wens@csie.org>
Message-ID: <20180424115311.5s5p5ryyswq7xmat@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 07:34:20PM +0800, Chen-Yu Tsai wrote:
> The dtb entry for the Banana Pi M2 Zero in the device tree makefile
> somehow ended up in between two Orange Pi boards.
> 
> Move it so the list is properly sorted.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/0b0c038e/attachment.sig>

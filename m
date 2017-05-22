From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 May 2017 09:21:41 +0200
Subject: [PATCH 3/6] pinctrl: sunxi: Fix SPDIF function name for A83T
In-Reply-To: <20170522062552.19026-4-wens@csie.org>
References: <20170522062552.19026-1-wens@csie.org>
 <20170522062552.19026-4-wens@csie.org>
Message-ID: <20170522072141.3cgcmlwq7mrlmspb@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 02:25:49PM +0800, Chen-Yu Tsai wrote:
> We use well known standard names for functions that have name, such as
> I2C, SPI, SPDIF, etc..
> 
> Fix the function name of SPDIF, which was named OWA (One Wire Audio)
> based on Allwinner datasheets.
> 
> Fixes: 4730f33f0d82 ("pinctrl: sunxi: add allwinner A83T PIO controller
> 		      support")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170522/c5dcff97/attachment.sig>

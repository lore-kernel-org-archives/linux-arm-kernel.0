From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 May 2017 09:21:09 +0200
Subject: [PATCH 1/6] clk: sunxi-ng: a83t: Fix PLL lock status register
 offset
In-Reply-To: <20170522062552.19026-2-wens@csie.org>
References: <20170522062552.19026-1-wens@csie.org>
 <20170522062552.19026-2-wens@csie.org>
Message-ID: <20170522072109.a7sb4ahnd4iy4qdc@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 02:25:47PM +0800, Chen-Yu Tsai wrote:
> The offset for the PLL lock status register was incorrectly set to
> 0x208, which actually points to an unused register. The correct
> register offset is 0x20c.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170522/cbac543f/attachment-0001.sig>

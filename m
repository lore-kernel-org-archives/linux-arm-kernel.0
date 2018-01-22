From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Jan 2018 14:26:51 +0100
Subject: [PATCH] clk: sunxi-ng: remove select on obsolete SUNXI_CCU_X
 kconfig name
In-Reply-To: <20180119141906.7339-1-clabbe.montjoie@gmail.com>
References: <20180119141906.7339-1-clabbe.montjoie@gmail.com>
Message-ID: <20180122132651.fuhkwwa43ewrzqzq@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 19, 2018 at 03:19:06PM +0100, Corentin Labbe wrote:
> The following symbols:
> SUNXI_CCU_DIV
> SUNXI_CCU_MULT
> SUNXI_CCU_NK
> SUNXI_CCU_NKM
> SUNXI_CCU_NM
> SUNXI_CCU_MP
> SUNXI_CCU_PHASE
> were removed with the commit 06e226c7fb23 ("clk: sunxi-ng: Move all clock types to a library")
> So selecting them is useless.
> 
> Fixes: c84f5683f6e9 ("clk: sunxi-ng: Add sun4i/sun7i CCU driver")
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Queued for 4.17, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180122/429bc64f/attachment.sig>

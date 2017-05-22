From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 May 2017 09:20:47 +0200
Subject: [PATCH 2/6] clk: sunxi-ng: a83t: Fix audio PLL divider offset
In-Reply-To: <20170522062552.19026-3-wens@csie.org>
References: <20170522062552.19026-1-wens@csie.org>
 <20170522062552.19026-3-wens@csie.org>
Message-ID: <20170522072047.bffdbwkz2nqvhums@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 02:25:48PM +0800, Chen-Yu Tsai wrote:
> The divider of the audio PLL has an offset of 1.
> Fix this in the driver.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170522/9e4c4f2e/attachment.sig>

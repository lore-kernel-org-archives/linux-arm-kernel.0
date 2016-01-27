From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jan 2016 16:52:36 +0100
Subject: [PATCH RFC 05/11] clk: sunxi: unmap registers in
 sunxi_factors_clk_setup if register call fails
In-Reply-To: <1453727747-23307-6-git-send-email-wens@csie.org>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
 <1453727747-23307-6-git-send-email-wens@csie.org>
Message-ID: <20160127155236.GI4317@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 09:15:41PM +0800, Chen-Yu Tsai wrote:
> sunxi_factors_clk_setup() does not unmap registers when
> sunxi_factors_register() fails.
> 
> This patch adds proper error handling, and also an error message
> when sunxi_factors_register() fails. Also use the full DT node name
> in error messages, as the node name is often just "clk", which is
> useless.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

APplied, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/857bbdf2/attachment.sig>

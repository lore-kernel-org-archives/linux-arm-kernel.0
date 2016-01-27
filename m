From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jan 2016 16:51:41 +0100
Subject: [PATCH RFC 03/11] clk: sunxi: factors: Add clk cleanup in
 sunxi_factors_register() error path
In-Reply-To: <1453727747-23307-4-git-send-email-wens@csie.org>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
 <1453727747-23307-4-git-send-email-wens@csie.org>
Message-ID: <20160127155141.GG4317@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 09:15:39PM +0800, Chen-Yu Tsai wrote:
> sunxi_factors_register() does not check for failures or cleanup after
> clk_register_composite() or other clk-related calls.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/af3f5c89/attachment.sig>

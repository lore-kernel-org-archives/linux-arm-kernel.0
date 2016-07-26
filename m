From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Jul 2016 10:57:11 +0200
Subject: [PATCH 2/9] clk: sunxi-ng: nk: Make ccu_nk_find_best static
In-Reply-To: <1469516671-19377-3-git-send-email-wens@csie.org>
References: <1469516671-19377-1-git-send-email-wens@csie.org>
 <1469516671-19377-3-git-send-email-wens@csie.org>
Message-ID: <20160726085711.GC7190@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 03:04:24PM +0800, Chen-Yu Tsai wrote:
> make C=2 reports:
> 
>   CHECK   drivers/clk/sunxi-ng/ccu_nk.c
> drivers/clk/sunxi-ng/ccu_nk.c:17:6: warning: symbol 'ccu_nk_find_best' was
> not declared. Should it be static?
> 
> ccu_nk_find_best is only used within ccu_nk.c. So make it static to get
> rid of this warning.
> 
> Fixes: adbfb0056e03 ("clk: sunxi-ng: Add N-K-factor clock support")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160726/53f4bf71/attachment.sig>

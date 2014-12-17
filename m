From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 17 Dec 2014 22:37:33 +0100
Subject: [PATCH] clk: sunxi: Fix sun6i_ahb1_clk_determine_rate clock to
 return clk_hw
In-Reply-To: <1418835558-3907-1-git-send-email-wens@csie.org>
References: <1418835558-3907-1-git-send-email-wens@csie.org>
Message-ID: <20141217213733.GS4337@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 18, 2014 at 12:59:18AM +0800, Chen-Yu Tsai wrote:
> The determine_rate clock op callback was changed to return clk_hw in
> commit 646cafc6aa4d ("clk: Change clk_ops->determine_rate to return a
> clk_hw as the best parent"). This fixes the sun6i AHB1 clock driver.
> 
> Fixes: 544473f clk: sunxi: unify sun6i AHB1 clock with proper PLL6 pre-divider
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> Hi Maxime,
> 
> Since you've queued the sun6i ahb1 patches for 3.20, but haven't published
> them, could you squash this one in when you do?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141217/3de83379/attachment.sig>

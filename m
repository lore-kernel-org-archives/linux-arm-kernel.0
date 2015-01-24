From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 24 Jan 2015 16:29:44 +0100
Subject: [PATCH v2] clk: sunxi: fix sun6i PLL1 .recalc_rate() result
In-Reply-To: <1422088959-23365-1-git-send-email-wens@csie.org>
References: <1422088959-23365-1-git-send-email-wens@csie.org>
Message-ID: <20150124152944.GE8470@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Sat, Jan 24, 2015 at 04:42:39PM +0800, Chen-Yu Tsai wrote:
> PLL1 on sun6i has its N factor start from 1 (N = register value + 1).
> Make the factors clk driver aware of this so clk_factors_recalc_rate()
> gives the correct result.
> 
> Cc: <stable@vger.kernel.org> # 3.12 9a5e6c7eb5cc clk: sunxi: Support factor
> Cc: <stable@vger.kernel.org> # 3.12
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Could you queue this for 3.19?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150124/30267c02/attachment.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 May 2014 20:43:35 +0200
Subject: [PATCH 07/22] clk: sunxi: Fix PLL6 calculation on sun6i
In-Reply-To: <1400831485-28576-8-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-8-git-send-email-wens@csie.org>
Message-ID: <20140525184335.GL10768@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 03:51:10PM +0800, Chen-Yu Tsai wrote:
> The N factor for PLL6 counts from 1 to 32, as specified in the A23
> manual, and shown in Allwinner's original code.
> 
> This patch fixes the N factor in the clock driver, as well as the
> comment describing it.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140525/fbb2b53e/attachment.sig>

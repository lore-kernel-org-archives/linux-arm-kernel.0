From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 May 2014 20:43:51 +0200
Subject: [PATCH 06/22] clk: sunxi: Support factor clocks with N
 multiplier factor starting from 1
In-Reply-To: <1400831485-28576-7-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-7-git-send-email-wens@csie.org>
Message-ID: <20140525184351.GM10768@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 03:51:09PM +0800, Chen-Yu Tsai wrote:
> The PLLs on newer Allwinner SoC's, such as the A31 and A23, have a
> N multiplier factor that starts from 1, not 0.
> 
> This patch adds an option to the clock driver's config data structures
> to define the difference.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140525/3f1f39c0/attachment.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Jul 2014 10:47:00 +0200
Subject: [PATCH v3 1/9] clk: sunxi: Add A23 APB0 divider clock support
In-Reply-To: <1404399349-20237-2-git-send-email-wens@csie.org>
References: <1404399349-20237-1-git-send-email-wens@csie.org>
 <1404399349-20237-2-git-send-email-wens@csie.org>
Message-ID: <20140707084700.GD16262@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 10:55:41PM +0800, Chen-Yu Tsai wrote:
> The A23 has an almost identical PRCM clock tree. The difference in
> the APB0 clock is the smallest divisor is 1, instead of 2.
> 
> This patch adds a separate sun8i-a23-apb0-clk driver to support it.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Just applied, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140707/15872668/attachment.sig>

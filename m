From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Nov 2016 07:35:46 +0100
Subject: [PATCH] clk: sunxi-ng: fix PLL_CPUX adjusting on H3
In-Reply-To: <20161125002852.18097-1-megous@megous.com>
References: <20161125002852.18097-1-megous@megous.com>
Message-ID: <20161125063546.n3s3dpxdi6ashjtq@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 01:28:47AM +0100, megous at megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> When adjusting PLL_CPUX on H3, the PLL is temporarily driven
> too high, and the system becomes unstable (oopses or hangs).
> 
> Add a notifier to avoid this situation by temporarily switching
> to a known stable 24 MHz oscillator.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Tested-by: Lutz Sammer <johns98@gmx.net>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161125/8ebd4b9a/attachment.sig>

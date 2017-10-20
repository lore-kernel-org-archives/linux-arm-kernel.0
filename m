From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Oct 2017 09:29:04 +0200
Subject: [PATCH] clk: sunxi: fix build warning
In-Reply-To: <20171019190948.5754-1-clabbe.montjoie@gmail.com>
References: <20171019190948.5754-1-clabbe.montjoie@gmail.com>
Message-ID: <20171020072904.kfmx65lbqd3uw2qh@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen, Mike,

On Thu, Oct 19, 2017 at 09:09:48PM +0200, Corentin Labbe wrote:
> This patch fix the following build warning:
> drivers/clk/sunxi/clk-factors.c:279:14: warning: variable 'name' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Can you apply that patch directly? This is the only fix that we're
supposed to have for 4.14.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171020/cb7c8431/attachment.sig>

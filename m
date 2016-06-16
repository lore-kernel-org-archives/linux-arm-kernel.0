From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Jun 2016 09:18:48 +0200
Subject: [PATCH] clk: sunxi: remove unused variable
In-Reply-To: <20160615155537.3342366-1-arnd@arndb.de>
References: <20160615155537.3342366-1-arnd@arndb.de>
Message-ID: <20160616071848.GD5144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 05:55:23PM +0200, Arnd Bergmann wrote:
> The only use of the local num_parents variable was remove,
> so we now get a warning:
> 
> drivers/clk/sunxi/clk-sun4i-tcon-ch1.c: In function 'tcon_ch1_get_parent':
> drivers/clk/sunxi/clk-sun4i-tcon-ch1.c:82:6: error: unused variable 'num_parents' [-Werror=unused-variable]
> 
> This removes the variable.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 4de2d58bc973 ("clk: sunxi: tcon-ch1: Do not return a negative error in get_parent")

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160616/a89b1b2b/attachment.sig>

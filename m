From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Feb 2017 11:52:20 +0100
Subject: [PATCH] clk: sunxi-ng: select SUNXI_CCU_MULT for sun5i
In-Reply-To: <20170202143417.3514875-1-arnd@arndb.de>
References: <20170202143417.3514875-1-arnd@arndb.de>
Message-ID: <20170206105220.zplxoeckwbfypwxx@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2017 at 03:33:57PM +0100, Arnd Bergmann wrote:
> We get a link error when CCU_MULT is not set with the
> newly added driver:
> 
> drivers/clk/sunxi-ng/ccu-sun5i.o:(.data.__compound_literal.17+0x4): undefined reference to `ccu_mult_ops'
> drivers/clk/sunxi-ng/ccu-sun5i.o:(.data.__compound_literal.5+0x4): undefined reference to `ccu_mult_ops'
> 
> Fixes: 5e73761786d6 ("clk: sunxi-ng: Add sun5i CCU driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Mike, Stephen, can you apply it directly?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170206/26e9fa96/attachment.sig>

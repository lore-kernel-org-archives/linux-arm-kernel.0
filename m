From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 6 Feb 2017 14:49:10 -0800
Subject: [PATCH] clk: sunxi-ng: select SUNXI_CCU_MULT for sun5i
In-Reply-To: <20170202143417.3514875-1-arnd@arndb.de>
References: <20170202143417.3514875-1-arnd@arndb.de>
Message-ID: <20170206224910.GH25384@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02, Arnd Bergmann wrote:
> We get a link error when CCU_MULT is not set with the
> newly added driver:
> 
> drivers/clk/sunxi-ng/ccu-sun5i.o:(.data.__compound_literal.17+0x4): undefined reference to `ccu_mult_ops'
> drivers/clk/sunxi-ng/ccu-sun5i.o:(.data.__compound_literal.5+0x4): undefined reference to `ccu_mult_ops'
> 
> Fixes: 5e73761786d6 ("clk: sunxi-ng: Add sun5i CCU driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

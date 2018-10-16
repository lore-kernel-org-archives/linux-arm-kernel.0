From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 16 Oct 2018 15:44:07 -0700
Subject: [PATCH V6 2/4] clk: add new APIs to operate on all available
 clocks
In-Reply-To: <1535690756-22234-3-git-send-email-aisheng.dong@nxp.com>
References: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
 <1535690756-22234-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <153972984725.5275.508428182184772125@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Dong Aisheng (2018-08-30 21:45:54)
> This patch introduces of_clk_bulk_get_all and clk_bulk_x_all APIs
> to users who just want to handle all available clocks from device tree
> without need to know the detailed clock information likes clock numbers
> and names. This is useful in writing some generic drivers to handle clock
> part.
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Tested-by: Thor Thayer <thor.thayer@linux.intel.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Applied to clk-next

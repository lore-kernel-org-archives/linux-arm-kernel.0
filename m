From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 16 Oct 2018 15:44:04 -0700
Subject: [PATCH V6 1/4] clk: bulk: add of_clk_bulk_get()
In-Reply-To: <1535690756-22234-2-git-send-email-aisheng.dong@nxp.com>
References: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
 <1535690756-22234-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <153972984485.5275.12234542827124661483@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Dong Aisheng (2018-08-30 21:45:53)
> 'clock-names' property is optional in DT, so of_clk_bulk_get() is
> introduced here to handle this for DT users without 'clock-names'
> specified. Later clk_bulk_get_all() will be implemented on top of
> it and this API will be kept private until someone proves they need
> it because they don't have a struct device pointer.
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Reported-by: Shawn Guo <shawnguo@kernel.org>
> Tested-by: Thor Thayer <thor.thayer@linux.intel.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Applied to clk-next

From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 14 Nov 2018 14:30:03 -0800
Subject: [PATCH v2] clk: zynqmp: handle fixed factor param query error
In-Reply-To: <1542181609-12189-1-git-send-email-rajan.vaja@xilinx.com>
References: <1539762392-12512-1-git-send-email-rajan.vaja@xilinx.com>
 <1542181609-12189-1-git-send-email-rajan.vaja@xilinx.com>
Message-ID: <154223460319.88331.12722047207173915744@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Rajan Vaja (2018-11-13 23:46:49)
> Return proper error code in case query for fixed factor
> parameter fails. This also fixes build warning for set
> but not used variable 'ret'.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Fixes: 3fde0e16d016 ("drivers: clk: Add ZynqMP clock driver")
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-fixes

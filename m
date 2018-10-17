From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 17 Oct 2018 08:22:00 -0700
Subject: [PATCH] clk: zynqmp: handle fixed factor param query error
In-Reply-To: <1539762392-12512-1-git-send-email-rajan.vaja@xilinx.com>
References: <1539762392-12512-1-git-send-email-rajan.vaja@xilinx.com>
Message-ID: <153978972088.5275.4505414322881956934@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Rajan Vaja (2018-10-17 00:46:32)
> Return proper error code in case query for fixed factor
> parameter fails. This also fixes build warning for set
> but not used variable 'ret'.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>

Fixes tag? And I think this is going through arm-soc already? If so,

Acked-by: Stephen Boyd <sboyd@kernel.org>

with the appropriate fixes tag added.

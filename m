From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Apr 2018 11:33:08 -0700
Subject: [PATCH v6 1/4] clk: imx: Add CLK_IS_CRITICAL flag for busy
 divider and busy mux
In-Reply-To: <1521512644-25265-1-git-send-email-ping.bai@nxp.com>
References: <1521512644-25265-1-git-send-email-ping.bai@nxp.com>
Message-ID: <152303958867.94378.5765405972950548052@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Bai Ping (2018-03-19 19:24:01)
> The busy divider and busy mux is actually used by the system critical clocks,
> so add 'CLK_IS_CRITICAL' to clocks registered with these two type.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Applied to clk-next

From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 16 Mar 2018 15:46:21 -0700
Subject: [PATCH 1/1] clk: add more __must_check for bulk APIs
In-Reply-To: <1516710285-23683-1-git-send-email-aisheng.dong@nxp.com>
References: <1516710285-23683-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <152124038126.242365.15669852275487154303@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Dong Aisheng (2018-01-23 04:24:45)
> we need it even when !CONFIG_HAVE_CLK because it allows
> us to catch missing checking return values in the non-clk
> compile configurations too. More test coverage.
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Applied to clk-next

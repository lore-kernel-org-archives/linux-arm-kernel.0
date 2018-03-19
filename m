From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 19 Mar 2018 10:45:53 -0700
Subject: [PATCH v3 02/10] clk: qcom: Make clk_alpha_pll_configure
 available to modules
In-Reply-To: <1518616792-29028-3-git-send-email-ilialin@codeaurora.org>
References: <1518616792-29028-1-git-send-email-ilialin@codeaurora.org>
 <1518616792-29028-3-git-send-email-ilialin@codeaurora.org>
Message-ID: <152148155340.242365.15501379032374522306@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ilia Lin (2018-02-14 05:59:44)
> From: Rajendra Nayak <rnayak@codeaurora.org>
> 
> Allow clk_alpha_pll_configure to be called from loadable
> kernel modules.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---

Applied to clk-next

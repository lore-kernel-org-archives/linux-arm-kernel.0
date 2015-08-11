From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 10 Aug 2015 23:59:27 -0700
Subject: [PATCH v8 02/13] clk: qcom: gdsc: Prepare common clk probe to
 register gdscs
In-Reply-To: <1438857474-20262-3-git-send-email-rnayak@codeaurora.org>
References: <1438857474-20262-1-git-send-email-rnayak@codeaurora.org>
 <1438857474-20262-3-git-send-email-rnayak@codeaurora.org>
Message-ID: <20150811065927.GD2839@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06, Rajendra Nayak wrote:
> The common clk probe registers a clk provider and a reset controller.
> Update it to register a genpd provider using the gdsc data provided
> by each platform.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

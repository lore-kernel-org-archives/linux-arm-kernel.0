From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 10 Aug 2015 23:59:23 -0700
Subject: [PATCH v8 01/13] clk: qcom: Add support for GDSCs
In-Reply-To: <1438857474-20262-2-git-send-email-rnayak@codeaurora.org>
References: <1438857474-20262-1-git-send-email-rnayak@codeaurora.org>
 <1438857474-20262-2-git-send-email-rnayak@codeaurora.org>
Message-ID: <20150811065923.GC2839@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06, Rajendra Nayak wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> GDSCs (Global Distributed Switch Controllers) are responsible for
> safely collapsing and restoring power to peripherals in the SoC.
> These are best modelled as power domains using genpd and given
> the registers are scattered throughout the clock controller register
> space, its best to have the support added through the clock driver.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

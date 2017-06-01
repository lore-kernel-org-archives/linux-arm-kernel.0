From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 1 Jun 2017 01:28:04 -0700
Subject: [PATCH 2/2 v2] clk: qoriq: Separate root input clock for core
 PLLs on ls1012a
In-Reply-To: <1489977443-33582-2-git-send-email-andy.tang@nxp.com>
References: <1489977443-33582-1-git-send-email-andy.tang@nxp.com>
 <1489977443-33582-2-git-send-email-andy.tang@nxp.com>
Message-ID: <20170601082804.GE20170@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20, Yuantian Tang wrote:
> From: Scott Wood <oss@buserror.net>
> 
> ls1012a has separate input root clocks for core PLLs versus the
> platform PLL, with the latter described as sysclk in the hw docs.
> If a second input clock, named "coreclk", is present, this clock will be
> used for the core PLLs.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

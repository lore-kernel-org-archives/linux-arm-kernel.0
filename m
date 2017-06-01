From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 1 Jun 2017 01:27:17 -0700
Subject: [PATCH 1/2 v2] dt-bindings: qoriq-clock: Add coreclk
In-Reply-To: <1489977443-33582-1-git-send-email-andy.tang@nxp.com>
References: <1489977443-33582-1-git-send-email-andy.tang@nxp.com>
Message-ID: <20170601082717.GC20170@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20, Yuantian Tang wrote:
> From: Scott Wood <oss@buserror.net>
> 
> ls1012a has separate input root clocks for core PLLs versus the platform
> PLL, with the latter described as sysclk in the hw docs.
> Update the qoriq-clock binding to allow a second input clock, named
> "coreclk".  If present, this clock will be used for the core PLLs.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

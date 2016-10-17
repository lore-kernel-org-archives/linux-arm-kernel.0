From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 15:27:38 -0700
Subject: [PATCH] clk: core: add __init decoration for
 CLK_OF_DECLARE_DRIVER function
In-Reply-To: <1475917178-15488-1-git-send-email-shawn.guo@linaro.org>
References: <1475917178-15488-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20161017222738.GG8871@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08, Shawn Guo wrote:
> The new introduced macro CLK_OF_DECLARE_DRIVER is usually used to
> declare clock driver init functions, which are mostly decorated with
> __init.  Add __init decoration for CLK_OF_DECLARE_DRIVER function to
> avoid causing section mismatch warnings on client clock drivers.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

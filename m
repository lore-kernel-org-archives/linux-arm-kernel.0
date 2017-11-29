From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 29 Nov 2017 09:04:53 -0800
Subject: [PATCH] clk: fix compile testing of scpi clk driver
In-Reply-To: <24058ecb-9f12-f7e1-503d-bd98eb894c6c@gmail.com>
References: <24058ecb-9f12-f7e1-503d-bd98eb894c6c@gmail.com>
Message-ID: <20171129170453.GA7698@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/28, Heiner Kallweit wrote:
> We now have a hard dependency on ARM_SCPI_PROTOCOL and may end up with
> the following error:
> ERROR: "get_scpi_ops" [drivers/clk/clk-scpi.ko] undefined!
> Fix this by removing COMPILE_TEST from COMMON_CLK_SCPI dependencies.
> 
> Fixes: f7fee8be06a6 "firmware: arm_scpi: remove default for get_scpi_ops if not reachable"

I don't see this commit anywhere. Is this a future issue?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

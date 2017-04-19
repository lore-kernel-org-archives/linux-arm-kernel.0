From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 19 Apr 2017 09:14:35 -0700
Subject: [PATCH v2 1/2] clk: imx7d: fix USDHC NAND clock
In-Reply-To: <20170410210015.1620-1-stefan@agner.ch>
References: <20170410210015.1620-1-stefan@agner.ch>
Message-ID: <20170419161435.GA7065@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10, Stefan Agner wrote:
> The USDHC NAND root clock is not gated by any CCM clock gate. Remove
> the bogus gate definition.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---

Can this be applied? It's followed by a dtsi change and there is
zero information about if the two depend on each other. Please
add cover letters for these sorts of things in the future
indicating how you expect merging to work.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 Dec 2017 10:43:44 -0800
Subject: [PATCH] clk: pxa: unbreak lookup of CLK_POUT
In-Reply-To: <20171226133036.11432-1-grinberg@compulab.co.il>
References: <20171226133036.11432-1-grinberg@compulab.co.il>
Message-ID: <20171228184344.GP7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/26, Igor Grinberg wrote:
> Since switching to clk drivers, the CLK_POUT cannot be searched for by
> clk_get() API and thus it returns with ENOENT.
> Register it with the clk_lookup and thus unbreak the users of it.
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

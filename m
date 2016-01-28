From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 Jan 2016 00:31:50 -0800
Subject: [PATCH v4 02/13] clk: at91: make use of syscon/regmap internally
In-Reply-To: <1453911072-23608-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1453911072-23608-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1453911072-23608-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160128083150.GK12841@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27, Alexandre Belloni wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> Use the regmap coming from syscon to access the registers instead of using
> pmc_read/pmc_write. This allows to avoid passing the at91_pmc structure to
> the child nodes of the PMC.
> 
> The final benefit is to have each clock register itself instead of having
> to iterate over the children.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

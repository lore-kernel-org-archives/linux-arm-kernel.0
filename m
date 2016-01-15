From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 14 Jan 2016 18:04:53 -0800
Subject: [PATCH v3 06/13] clk: at91: pmc: merge at91_pmc_init in
 atmel_pmc_probe
In-Reply-To: <1449248628-3486-7-git-send-email-alexandre.belloni@free-electrons.com>
References: <1449248628-3486-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1449248628-3486-7-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160115020452.GM22188@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04, Alexandre Belloni wrote:
> at91_pmc_init() doesn't do much anymore, merge it in atmel_pmc_probe().
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

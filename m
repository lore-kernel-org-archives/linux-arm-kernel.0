From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 14 Jan 2016 18:07:39 -0800
Subject: [PATCH v3 13/13] clk: at91: pmc: drop at91_pmc_base
In-Reply-To: <1449248628-3486-14-git-send-email-alexandre.belloni@free-electrons.com>
References: <1449248628-3486-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1449248628-3486-14-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160115020739.GP22188@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04, Alexandre Belloni wrote:
> at91_pmc_base is not used anymore, remove it along with at91_pmc_read and
> at91_pmc_write.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

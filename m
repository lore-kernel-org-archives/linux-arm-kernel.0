From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 14 Jan 2016 18:08:23 -0800
Subject: [PATCH v3 03/13] clk: at91: clk-main: factorize irq handling
In-Reply-To: <1449248628-3486-4-git-send-email-alexandre.belloni@free-electrons.com>
References: <1449248628-3486-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1449248628-3486-4-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160115020823.GQ22188@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04, Alexandre Belloni wrote:
> The three different irq handlers are doing the same thing, factorize their
> code in a generic irq handler.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

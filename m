From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 14 Jan 2016 18:04:39 -0800
Subject: [PATCH v3 07/13] clk: at91: pmc: move pmc structures to C file
In-Reply-To: <1449248628-3486-8-git-send-email-alexandre.belloni@free-electrons.com>
References: <1449248628-3486-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1449248628-3486-8-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160115020439.GL22188@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04, Alexandre Belloni wrote:
> pmc.c is now the only user of struct at91_pmc*, move their definition in
> the C file.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

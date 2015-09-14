From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 14 Sep 2015 14:57:28 -0700
Subject: [PATCH 2/2] clk: at91: system: don't try to free_irq when there
 is no IRQ
In-Reply-To: <1441982047-11303-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1441982047-11303-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1441982047-11303-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150914215728.GB23081@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11, Alexandre Belloni wrote:
> In the error path of at91_clk_register_system(), sys->irq is freed
> unconditionally but it may not exist or be request at all.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

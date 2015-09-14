From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 14 Sep 2015 14:57:24 -0700
Subject: [PATCH 1/2] clk: at91: utmi: use pmc_read when the at91_pmc is
 available
In-Reply-To: <1441982047-11303-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1441982047-11303-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150914215724.GA23081@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11, Alexandre Belloni wrote:
> at91_pmc_read is a workaround to allow external drivers to acces some
> registers of the PMC. There is no need for it in clk-utmi.c as we aready
> have a pointer to the struct at91_pmc.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

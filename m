From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 Jan 2016 00:30:33 -0800
Subject: [PATCH v4 12/13] clk: at91: pmc: remove useless capacities
 handling
In-Reply-To: <1453911072-23608-13-git-send-email-alexandre.belloni@free-electrons.com>
References: <1453911072-23608-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1453911072-23608-13-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160128083033.GH12841@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27, Alexandre Belloni wrote:
> Capacities only handles interrupts and they are not use anymore. Remove the
> whole initialisation.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

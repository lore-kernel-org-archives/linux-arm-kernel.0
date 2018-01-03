From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 2 Jan 2018 17:46:58 -0800
Subject: [PATCH v7 2/5] clk: aspeed: Register core clocks
In-Reply-To: <20171222024522.10362-3-joel@jms.id.au>
References: <20171222024522.10362-1-joel@jms.id.au>
 <20171222024522.10362-3-joel@jms.id.au>
Message-ID: <20180103014658.GQ7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22, Joel Stanley wrote:
> This registers the core clocks; those which are required to calculate
> the rate of the timer peripheral so the system can load a clocksource
> driver.
> 
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

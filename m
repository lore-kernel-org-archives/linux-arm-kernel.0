From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 14 May 2015 18:12:25 -0700
Subject: [PATCH v3 1/9] clk: berlin: move to a dedicated sub-node
In-Reply-To: <1428417909-27378-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1428417909-27378-1-git-send-email-antoine.tenart@free-electrons.com>
 <1428417909-27378-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20150515011225.GG31753@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07, Antoine Tenart wrote:
> The Berlin clock driver was sharing a DT node with the pin controller
> and the reset driver. All these devices are now sub-nodes of the chip
> controller. This patch rework the Berlin clock driver to allow moving
> the Berlin clock DT bindings into their own sub-node of the chip
> controller node.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

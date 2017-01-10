From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 9 Jan 2017 16:26:43 -0800
Subject: [PATCH] clk: mvebu: adjust AP806 CPU clock frequencies to
 production chip
In-Reply-To: <1482408494-7429-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1482408494-7429-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20170110002643.GJ17126@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22, Thomas Petazzoni wrote:
> This commit adjusts the list of possible "Sample At Reset" values that
> define the CPU clock frequency of the AP806 (part of Marvell Armada
> 7K/8K) to the values that have been validated with the production
> chip. Earlier values were preliminary.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

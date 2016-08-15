From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 15 Aug 2016 14:09:41 -0700
Subject: [PATCH v3 2/6] clk: mvebu: Add the xtal clock for Armada 3700 SoC
In-Reply-To: <1468935742-11218-3-git-send-email-gregory.clement@free-electrons.com>
References: <1468935742-11218-1-git-send-email-gregory.clement@free-electrons.com>
 <1468935742-11218-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160815210941.GA361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19, Gregory CLEMENT wrote:
> This clock is the parent of all the Armada 3700 clocks. It is a fixed
> rate clock which depends on the gpio configuration read when resetting
> the SoC.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

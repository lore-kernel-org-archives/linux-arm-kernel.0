From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 6 Jul 2015 15:12:02 -0700
Subject: [PATCH 6/7] clk: rockchip: add missing include guards
In-Reply-To: <1436086820-3757-7-git-send-email-heiko@sntech.de>
References: <1436086820-3757-1-git-send-email-heiko@sntech.de>
 <1436086820-3757-7-git-send-email-heiko@sntech.de>
Message-ID: <20150706221202.GL20866@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05, Heiko Stuebner wrote:
> Review for the rk3368 turned up that the clock header was missing include
> guards. This is also true for the already existing clock binding headers,
> so add them.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

Applied to clk-rk3368.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

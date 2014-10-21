From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 21 Oct 2014 14:33:48 -0700
Subject: [PATCH v4 6/8] clk: Change clk_ops->determine_rate to return
 a clk_hw as the best parent
In-Reply-To: <1413812442-24956-7-git-send-email-tomeu.vizoso@collabora.com>
References: <1413812442-24956-1-git-send-email-tomeu.vizoso@collabora.com>
 <1413812442-24956-7-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <5446D13C.5020402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2014 06:40 AM, Tomeu Vizoso wrote:
> This is in preparation for clock providers to not have to deal with struct clk.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>
>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

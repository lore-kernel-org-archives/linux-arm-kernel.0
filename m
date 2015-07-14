From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 13 Jul 2015 17:40:48 -0700
Subject: [PATCH 2/5] clocksource: mediatek: Use GPT as sched clock source
In-Reply-To: <1436779969-18610-3-git-send-email-yingjoe.chen@mediatek.com>
References: <1436779969-18610-1-git-send-email-yingjoe.chen@mediatek.com>
 <1436779969-18610-3-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <20150714004048.GM30412@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13, Yingjoe Chen wrote:
> When cpu is in deep idle, arch timer will stop counting. Setup GPT as
> sched clock source so it can keep counting in idle.
> 
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

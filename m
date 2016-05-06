From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 6 May 2016 16:12:29 -0700
Subject: [PATCH v7 7/9] clk: mediatek: Enable critical clocks for MT2701
In-Reply-To: <1460621514-65191-8-git-send-email-jamesjj.liao@mediatek.com>
References: <1460621514-65191-1-git-send-email-jamesjj.liao@mediatek.com>
 <1460621514-65191-8-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <20160506231229.GJ3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14, James Liao wrote:
> Some system clocks should be turned on by default on MT2701.
> This patch enable these clocks when related clocks have
> been registered.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---

critical clks got merged now (sorry I'm slowly getting back to
looking at patches). Please use that flag.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 6 May 2016 16:02:14 -0700
Subject: [PATCH v7 8/9] clk: mediatek: Add config options for MT2701
 subsystem clocks
In-Reply-To: <1460621514-65191-9-git-send-email-jamesjj.liao@mediatek.com>
References: <1460621514-65191-1-git-send-email-jamesjj.liao@mediatek.com>
 <1460621514-65191-9-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <20160506230214.GH3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14, James Liao wrote:
> MT2701 subsystem clocks are optional and should be enabled only if
> their subsystem drivers are ready to control these clocks.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---

Why is this patch split off from the patch that introduces the
file?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

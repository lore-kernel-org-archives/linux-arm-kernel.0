From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 29 Jan 2016 16:30:24 -0800
Subject: [PATCH v2] clk: Move vendor's Kconfig into CCF menu section
In-Reply-To: <1453971537-5510-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1453971537-5510-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <20160130003024.GA12841@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28, James Liao wrote:
> Move all vendor's Kconfig into CCF menu section to prevent
> new drivers putting their Kconfig files in a wrong place.
> 
> Some Kconigs need to modify at the same time to avoid build
> warnings.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

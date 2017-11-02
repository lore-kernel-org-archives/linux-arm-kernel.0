From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Nov 2017 01:12:05 -0700
Subject: [PATCH v2 2/4] clk: mediatek: add the option for determining PLL
 source clock
In-Reply-To: <b90d46284cb527d1412352606912f5e8d18b3e53.1507174799.git.sean.wang@mediatek.com>
References: <cover.1507174799.git.sean.wang@mediatek.com>
 <b90d46284cb527d1412352606912f5e8d18b3e53.1507174799.git.sean.wang@mediatek.com>
Message-ID: <20171102081205.GG11011@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05, sean.wang at mediatek.com wrote:
> From: Chen Zhong <chen.zhong@mediatek.com>
> 
> Since the previous setup always sets the PLL using crystal 26MHz, this
> doesn't always happen in every MediaTek platform. So the patch added
> flexibility for assigning extra member for determining the PLL source
> clock.
> 
> Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Aug 2016 17:15:44 -0700
Subject: [PATCH v10 1/9] clk: mediatek: remove __init from clk
 registration functions
In-Reply-To: <1471332629-15722-2-git-send-email-erin.lo@mediatek.com>
References: <1471332629-15722-1-git-send-email-erin.lo@mediatek.com>
 <1471332629-15722-2-git-send-email-erin.lo@mediatek.com>
Message-ID: <20160819001544.GP361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16, Erin Lo wrote:
> From: James Liao <jamesjj.liao@mediatek.com>
> 
> Remove __init from functions that will be used by init functions
> that support probe deferral.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

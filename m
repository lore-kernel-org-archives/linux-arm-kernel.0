From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Aug 2016 17:18:05 -0700
Subject: [PATCH v10 8/9] arm: dts: mt2701: Add clock controller device
 nodes
In-Reply-To: <1471332629-15722-9-git-send-email-erin.lo@mediatek.com>
References: <1471332629-15722-1-git-send-email-erin.lo@mediatek.com>
 <1471332629-15722-9-git-send-email-erin.lo@mediatek.com>
Message-ID: <20160819001805.GR361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16, Erin Lo wrote:
> From: James Liao <jamesjj.liao@mediatek.com>
> 
> Add clock controller nodes for MT2701, include topckgen, infracfg,
> pericfg, apmixedsys, mmsys, imgsys, vdecsys, hifsys, ethsys and
> bdpsys. This patch also add two oscillators that provide clocks for
> MT2701.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---

This should go through arm-soc tree, so do you need a stable
branch in clk tree to pull through arm-soc, or are we going to
wait a release cycle on the dts patches?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

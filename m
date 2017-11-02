From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Nov 2017 01:11:59 -0700
Subject: [PATCH v2 4/4] clk: mediatek: add clocks dt-bindings required
 header for MT7622 SoC
In-Reply-To: <7e2a5ac16547f911b00017ba3fad4076dad4d7d8.1507174799.git.sean.wang@mediatek.com>
References: <cover.1507174799.git.sean.wang@mediatek.com>
 <7e2a5ac16547f911b00017ba3fad4076dad4d7d8.1507174799.git.sean.wang@mediatek.com>
Message-ID: <20171102081159.GE11011@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05, sean.wang at mediatek.com wrote:
> From: Chen Zhong <chen.zhong@mediatek.com>
> 
> Add the required header for the entire clocks dt-bindings exported
> from topckgen, apmixedsys, infracfg, pericfg, ethsys, pciesys, ssusbsys
> and audsys which could be found on MT7622 SoC.
> 
> Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---

This should be patch 3 instead of 4 so that patch 3 compiles...

Applied to clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

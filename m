From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 5 May 2015 22:54:10 -0700
Subject: [PATCH v12] clk: Add common clock support for Mediatek MT8135
 and MT8173
In-Reply-To: <1429778143-2074-1-git-send-email-s.hauer@pengutronix.de>
References: <1429778143-2074-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150506055410.GC10871@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23, Sascha Hauer wrote:
> The following changes since commit 39a8804455fb23f09157341d3ba7db6d7ae6ee76:
> 
>   Linux 4.0 (2015-04-12 15:12:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/sha/linux-2.6.git tags/v4.0-clk-mediatek-v12
> 
> for you to fetch changes up to e0ebeaa8a3f4a762cb9c2780170445aad15915d1:
> 
>   dt-bindings: ARM: Mediatek: Document devicetree bindings for clock/reset controllers (2015-04-23 10:22:34 +0200)
> 
> ----------------------------------------------------------------
> This patchset contains the initial common clock support for Mediatek SoCs.
> Mediatek SoC's clock architecture comprises of various PLLs, dividers, muxes
> and clock gates.

Applied to clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

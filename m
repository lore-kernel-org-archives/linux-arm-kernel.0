From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 15 May 2018 15:19:02 -0700
Subject: [PATCH v1] clk: mediatek: correct the clocks for MT2701 HDMI PHY
 module
In-Reply-To: <dc75b5b289d1f6e4914e60543c2611f387f0c164.1523944160.git.ryder.lee@mediatek.com>
References: <dc75b5b289d1f6e4914e60543c2611f387f0c164.1523944160.git.ryder.lee@mediatek.com>
Message-ID: <152642274258.237094.4546092795485779715@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ryder Lee (2018-04-17 05:30:27)
> The hdmitx_dig_cts clock signal is not a child of clk26m,
> and the actual output of the PLL block is derived from
> the tvdpll via a configurable PLL post-divider.
> 
> It is used as the PLL reference input to the HDMI PHY module.
> 
> Fixes: e9862118272a ("clk: mediatek: Add MT2701 clock support")
> Signed-off-by: Chunhui Dai <chunhui.dai@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---

Applied to clk-next

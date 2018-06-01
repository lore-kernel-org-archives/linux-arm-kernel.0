From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 01 Jun 2018 12:18:07 -0700
Subject: [PATCH V2 3/3] ARM: dts: imx7: correct enet ipg clock
In-Reply-To: <1526605266-18464-3-git-send-email-Anson.Huang@nxp.com>
References: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
 <1526605266-18464-3-git-send-email-Anson.Huang@nxp.com>
Message-ID: <152788068714.225090.5079106153189288626@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Anson Huang (2018-05-17 18:01:06)
> ENET "ipg" clock should be IMX7D_ENETx_IPG_ROOT_CLK
> rather than IMX7D_ENET_AXI_ROOT_CLK which is for ENET bus
> clock.
> 
> Based on Andy Duan's patch from the NXP kernel tree.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

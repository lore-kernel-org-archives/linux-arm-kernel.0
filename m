From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 01 Jun 2018 12:18:00 -0700
Subject: [PATCH V2 1/3] clk: imx7d: correct enet phy ref clock gates
In-Reply-To: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
References: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <152788068032.225090.8543051846810232845@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Anson Huang (2018-05-17 18:01:04)
> IMX7D_ENET_PHY_REF_ROOT_DIV supplies clock for PHY directly,
> there is no clock gate after it, rename it to
> IMX7D_ENET_PHY_REF_ROOT_CLK to avoid device tree change.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

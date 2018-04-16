From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 16 Apr 2018 11:32:24 -0700
Subject: [PATCH V2 1/2] clk: imx6sx: add missing lvds2 clock to the clock
 tree
In-Reply-To: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
References: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <152390354456.51482.5320966315016822540@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Anson Huang (2018-03-18 19:30:44)
> i.MX6SX has lvds2 (analog clock2), an I/O clock like lvds1.
> And this lvds2, along with lvds1, can be used to provide
> external clock source to the internal pll, such as pll4_audio
> and pll5_video.
> 
> This patch mainly adds the lvds2 to the clock tree and fix its
> relationship with pll accordingly.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Applied to clk-next

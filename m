From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Apr 2018 11:20:32 -0700
Subject: [RESEND 2/4] clk: imx7d: Correct dram pll type
In-Reply-To: <1522219599-10831-4-git-send-email-abel.vesa@nxp.com>
References: <1522219599-10831-1-git-send-email-abel.vesa@nxp.com>
 <1522219599-10831-4-git-send-email-abel.vesa@nxp.com>
Message-ID: <152303883286.143116.8912343462602782485@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Abel Vesa (2018-03-27 23:46:37)
> From: Anson Huang <b20788@freescale.com>
> 
> DRAM PLL is a audio/video type PLL, need to correct
> it to get correct ops of PLL.
> 
> There is a test_div placed before DRAM PLL's gate, so
> add this test div clk.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Applied to clk-next

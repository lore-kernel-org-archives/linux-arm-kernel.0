From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 01 Jun 2018 12:10:47 -0700
Subject: [PATCH] clk: imx6sl: correct ocram_podf clock type
In-Reply-To: <1526533248-21990-2-git-send-email-Anson.Huang@nxp.com>
References: <1526533248-21990-1-git-send-email-Anson.Huang@nxp.com>
 <1526533248-21990-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <152788024703.225090.10824571841764355947@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Anson Huang (2018-05-16 22:00:48)
> IMX6SL_CLK_OCRAM_PODF is a busy divider, its name in
> CCM_CDHIPR register of Reference Manual CCM chapter
> is axi_podf_busy, correct its clock type.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

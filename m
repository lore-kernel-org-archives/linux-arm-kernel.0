From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 29 Jun 2018 11:48:40 -0700
Subject: [PATCH] clk: imx6: fix video_27m parent for IMX6QDL_CLK_CKO1_SEL
In-Reply-To: <20180608101924.31195-1-pp@emlix.com>
References: <20180608101924.31195-1-pp@emlix.com>
Message-ID: <153029812029.143105.12945867831074005837@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Philipp Puschmann (2018-06-08 03:19:24)
> q/dl datasheets list the 5th selection value for ck01_sel as
> video_27M_clk_root.
> 
> By replacing the dummy value we then can set IMX6QDL_CLK_VIDEO_27M
> as parent for IMX6QDL_CLK_CKO1_SEL.
> 
> Signed-off-by: Philipp Puschmann <pp@emlix.com>
> ---

Applied to clk-next

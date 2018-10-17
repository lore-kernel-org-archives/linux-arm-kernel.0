From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 17 Oct 2018 08:26:29 -0700
Subject: [PATCH 1/2] clk: imx: cpu clock should be always critical
In-Reply-To: <1539756441-18776-1-git-send-email-Anson.Huang@nxp.com>
References: <1539756441-18776-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <153978998995.5275.238389804579286767@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Anson Huang (2018-10-16 23:11:59)
> Add CLK_IS_CRITICAL flag for cpu clock type to
> make cpu clock use count correct, as cpu clock
> should be always critical.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 25 Jul 2018 09:46:25 -0700
Subject: [PATCH V2 1/2] clk: imx: add ocram_s clock for i.mx6sx
In-Reply-To: <1531270739-3075-1-git-send-email-Anson.Huang@nxp.com>
References: <1531270739-3075-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <153253718536.48062.17677554340926815034@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Anson Huang (2018-07-10 17:58:58)
> i.MX6SX has a 16KB always-on ocram bank called
> ocram_s, and its clock gate in CCM CCGR1 CG14
> needs to be enabled before access, add it to
> clock tree.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

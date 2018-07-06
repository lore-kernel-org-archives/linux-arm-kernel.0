From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Jul 2018 13:58:46 -0700
Subject: [PATCH 1/2] clk: imx6sll: add GPIO LPCGs
In-Reply-To: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
References: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <153091072630.143105.2849049240391576710@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Anson Huang (2018-06-21 23:32:33)
> According to Reference Manual Rev.0, 06/2017,
> there are GPIO LPCGs defined in CCM CCGRs,
> add them into clock tree.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

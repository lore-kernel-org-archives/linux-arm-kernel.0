From: sboyd@kernel.org (Stephen Boyd)
Date: Thu, 18 Oct 2018 11:01:42 -0700
Subject: [PATCH] clk: imx7d: remove UART1 clock setting
In-Reply-To: <1539845238-24114-1-git-send-email-Anson.Huang@nxp.com>
References: <1539845238-24114-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <153988570270.5275.247396954378886936@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Anson Huang (2018-10-17 23:51:55)
> There is clock assignment in dtb for UART1, so setting
> UART1 clock in clock driver is NOT necessary.

Can you mention the commit that introduced the assignment and possibly
the file where it is done?

> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

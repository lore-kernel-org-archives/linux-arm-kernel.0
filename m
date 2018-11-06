From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 6 Nov 2018 15:34:24 +0000
Subject: [PATCH RESEND V4 0/9] clk: add imx7ulp clk support
In-Reply-To: <AM0PR04MB4211280B09B72F637FC5650280CB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB4211576EF2FE906A6B0C3F1680FB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211280B09B72F637FC5650280CB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <7e58f0dcf83a0bd8139e58e27bfa137fc186b4bf.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-11-06 at 15:30 +0000, A.s. Dong wrote:
> Gently Ping...

> drivers/clk/imx/clk-composite.c                    |  85 +++++++++

During review for 8m clocks a separate but different composite clk was
added. In order to avoid confusion that was named "clk-composite-8m.c", 
it would make sense to move the 7ulp code to clk-composite-7ulp.c.

--
Regards,
Leonard

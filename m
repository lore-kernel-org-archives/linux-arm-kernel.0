From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 7 Nov 2018 03:00:47 +0000
Subject: [PATCH RESEND V4 0/9] clk: add imx7ulp clk support
In-Reply-To: <7e58f0dcf83a0bd8139e58e27bfa137fc186b4bf.camel@nxp.com>
References: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB4211576EF2FE906A6B0C3F1680FB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211280B09B72F637FC5650280CB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <7e58f0dcf83a0bd8139e58e27bfa137fc186b4bf.camel@nxp.com>
Message-ID: <AM0PR04MB42118A6086D98F84542E954F80C40@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Leonard Crestez
> Sent: Tuesday, November 6, 2018 11:34 PM
[...]
> 
> On Tue, 2018-11-06 at 15:30 +0000, A.s. Dong wrote:
> > Gently Ping...
> 
> > drivers/clk/imx/clk-composite.c                    |  85 +++++++++
> 
> During review for 8m clocks a separate but different composite clk was added.
> In order to avoid confusion that was named "clk-composite-8m.c", it would
> make sense to move the 7ulp code to clk-composite-7ulp.c.
> 

I guess we can do it, thanks.

Regards
Dong Aisheng

> --
> Regards,
> Leonard

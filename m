From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 19 Mar 2018 13:48:48 -0700
Subject: [PATCH v5 2/4] clk: imx: add new gate/gate2 wrapper funtion
In-Reply-To: <AM3PR04MB3065CB215B6264649D64C9B80D70@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1520846957-22348-1-git-send-email-ping.bai@nxp.com>
 <1520846957-22348-2-git-send-email-ping.bai@nxp.com>
 <AM3PR04MB3065CB215B6264649D64C9B80D70@AM3PR04MB306.eurprd04.prod.outlook.com>
Message-ID: <152149252893.242365.10879210224353918456@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting A.s. Dong (2018-03-15 23:30:13)
> > -----Original Message-----
> > From: Jacky Bai
> > Sent: Monday, March 12, 2018 5:29 PM
> > To: sboyd at kernel.org; robh+dt at kernel.org; shawnguo at kernel.org;
> > kernel at pengutronix.de
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>; linux-clk at vger.kernel.org;
> > linux-arm-kernel at lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>;
> > A.s. Dong <aisheng.dong@nxp.com>; jacky.baip at gmail.com
> > Subject: [PATCH v5 2/4] clk: imx: add new gate/gate2 wrapper funtion
> > 
> > Add new gate/gate2 wrapper function to register clocks with optional flags.
> > 
> > Signed-off-by: Bai Ping <ping.bai@nxp.com>
> 
> AFAIK Stephen requested to switch to clk_hw based APIs when reviewing my
> mx7ulp clk driver. We may need some comments from Stephen here.
> 
> Hi Stefen,
> 
> Do you have any comments about this?
> 

Using clk_hw based APIs is preferred. If there's existing usage of
non-hw based APIs then it's OK to keep same style and change later.

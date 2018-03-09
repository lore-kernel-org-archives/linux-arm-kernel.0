From: ping.bai@nxp.com (Jacky Bai)
Date: Fri, 9 Mar 2018 05:00:45 +0000
Subject: [PATCH v4 1/4] driver: clk: imx: Add CLK_IS_CRITICAL flag for
 busy divider and busy mux
In-Reply-To: <20180309023136.GD3217@dragon>
References: <1520502445-22576-1-git-send-email-ping.bai@nxp.com>
 <20180309023136.GD3217@dragon>
Message-ID: <HE1PR04MB311302F75DB42DEB034EF61F87DE0@HE1PR04MB3113.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH v4 1/4] driver: clk: imx: Add CLK_IS_CRITICAL flag for busy
> divider and busy mux
> 
> On Thu, Mar 08, 2018 at 05:47:22PM +0800, Bai Ping wrote:
> > The busy divider and busy mux is actually used by the system critical
> > clocks, so add 'CLK_IS_CRITICAL' to clocks registered with these two type.
> >
> > Signed-off-by: Bai Ping <ping.bai@nxp.com>
> 
> "clk: imx: ..." for patch prefix is good enough.
> 

OK, will be updated in V5.

Jacky
> Shawn

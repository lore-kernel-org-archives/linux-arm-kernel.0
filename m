From: peng.fan@nxp.com (Peng Fan)
Date: Wed, 27 Dec 2017 02:19:58 +0000
Subject: [PATCH] arm: imx: suspend/resume: use outer_disable/resume
In-Reply-To: <DB6PR04MB3221C1B5362775C72B34B01088060@DB6PR04MB3221.eurprd04.prod.outlook.com>
References: <20171210120718.15197-1-peng.fan@nxp.com>
 <20171226091230.GP23070@X250>
 <DB6PR04MB3221C1B5362775C72B34B01088060@DB6PR04MB3221.eurprd04.prod.outlook.com>
Message-ID: <DB6PR04MB322107AFBE254F3B73E559CF88070@DB6PR04MB3221.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> >
> > On Sun, Dec 10, 2017 at 08:07:18PM +0800, Peng Fan wrote:
> > > Use outer_disable/resume for suspend/resume.
> > > With the two APIs used, code could be simplified and easy to extend
> > > to introduce l2c_write_sec for i.MX platforms when moving Linux
> > > Kernel runs in non-secure world.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > Cc: Dong Aisheng <aisheng.dong@nxp.com>
> >
> > Changed 'arm: ' prefix to 'ARM: ', and applied patch.
> 
> I just tested it on 6sx-sdb, seems this patch breaks 6sx. Could you first drop this
> patch? I'll send out v2 fix the 6sx issue soon.

I just send out V2 patch to fix the 6sx issue. Sorry for the inconvenience about V1
that break 6sx. Please review.

Thanks,
Peng.
.

> 
> Thanks,
> Peng.
> 
> >
> > Shawn

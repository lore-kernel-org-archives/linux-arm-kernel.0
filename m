From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 27 Dec 2017 02:33:57 +0000
Subject: [PATCH V2] ARM: imx: suspend/resume: use outer_disable/resume
In-Reply-To: <20171227023207.GX23070@X250>
References: <1514339867-28946-1-git-send-email-peng.fan@nxp.com>
 <20171227023207.GX23070@X250>
Message-ID: <AM3PR04MB3067ECFE7A7DAE48DFD124780070@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Wednesday, December 27, 2017 10:32 AM
> To: Peng Fan <peng.fan@nxp.com>
> Cc: A.s. Dong <aisheng.dong@nxp.com>; linux-kernel at vger.kernel.org; Russell
> King <linux@armlinux.org.uk>; Fabio Estevam <fabio.estevam@nxp.com>;
> Sascha Hauer <kernel@pengutronix.de>; van.freenix at gmail.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH V2] ARM: imx: suspend/resume: use
> outer_disable/resume
> 
> On Wed, Dec 27, 2017 at 09:57:47AM +0800, Peng Fan wrote:
> > Use outer_disable/resume for suspend/resume.
> > With the two APIs used, code could be simplified and easy to extend to
> > introduce l2c_write_sec for i.MX platforms when moving Linux Kernel
> > runs in non-secure world.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Dong Aisheng <aisheng.dong@nxp.com>
> 
> @Aisheng, can you please give it a test?
> 

Yes, of course.

Regards
Dong Aisheng

> Shawn

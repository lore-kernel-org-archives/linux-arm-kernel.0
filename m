From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 19 Apr 2018 22:02:37 +0800
Subject: [PATCH V2 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz
 clock source
In-Reply-To: <152410785516.46528.12432838242068784117@swboyd.mtv.corp.google.com>
References: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
 <1521426645-19246-2-git-send-email-Anson.Huang@nxp.com>
 <20180417142203.GM25429@dragon>
 <152410785516.46528.12432838242068784117@swboyd.mtv.corp.google.com>
Message-ID: <20180419140236.GU25429@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2018 at 08:17:35PM -0700, Stephen Boyd wrote:
> Quoting Shawn Guo (2018-04-17 07:22:05)
> > On Mon, Mar 19, 2018 at 10:30:45AM +0800, Anson Huang wrote:
> > > On i.MX6SX SabreAuto board, there is external 24MHz clock
> > > source for analog clock2, add this clock source to clock tree.
> > > 
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > > changes since V1:
> > >       remove unnecessary clocks container.
> > 
> > I understand this is suggested by Fabio, but I'm afraid that it's not
> > going to work with imx_obtain_fixed_clock() call, which is coded to
> > look for clocks under /clocks node.
> > 
> 
> Should patch #1 be dropped from clk tree?

No.  Patch #1 is good.

Shawn

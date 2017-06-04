From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 4 Jun 2017 10:32:25 +0800
Subject: [PATCH 1/2] ARM: dts: imx7d-pico: Add watchdog support
In-Reply-To: <CAOMZO5B+idRqeCpbwLyQ81Ks9vE09UKF=B++4cAc3R2ERJrNGg@mail.gmail.com>
References: <1495552569-18567-1-git-send-email-fabio.estevam@nxp.com>
 <20170525075102.GZ26102@dragon>
 <CAOMZO5B+idRqeCpbwLyQ81Ks9vE09UKF=B++4cAc3R2ERJrNGg@mail.gmail.com>
Message-ID: <20170604023223.GA4094@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 01, 2017 at 10:00:25AM -0300, Fabio Estevam wrote:
> Hi Shawn,
> 
> On Thu, May 25, 2017 at 4:51 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> > On Tue, May 23, 2017 at 12:16:08PM -0300, Fabio Estevam wrote:
> >> imx7d-pico has the WDOG1_B pin connected to the PMIC, so add the
> >> wdog1 node and use the 'fsl,ext-reset-output' property to
> >> properly describe it.
> >>
> >> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> >
> > Applied both, thanks.
> 
> Maybe you forgot to push them to your tree?

Hmm, it's been on imx/dt for quite a few days, and for-next needs to be
updated though.

Shawn

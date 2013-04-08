From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 08 Apr 2013 18:17:18 +0200
Subject: [PATCH 0/5] i.MX53 TVE clock patches
In-Reply-To: <CAOMZO5CjC4HEvZo7rqdN1inAz_=xif=5aANLPhB9oF_mygJeGg@mail.gmail.com>
References: <1365432383-7787-1-git-send-email-p.zabel@pengutronix.de>
 <CAOMZO5CjC4HEvZo7rqdN1inAz_=xif=5aANLPhB9oF_mygJeGg@mail.gmail.com>
Message-ID: <1365437838.6626.7.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Am Montag, den 08.04.2013, 12:26 -0300 schrieb Fabio Estevam:
> Hi Phiipp,
> 
> On Mon, Apr 8, 2013 at 11:46 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > Hi,
> >
> > the first two are just cleanups, the following three patches are changes
> > to the i.MX53 clock tree that are necessary to use the TVEv2 module as
> > VGA output on the Freescale i.MX53-QSB or TQ MBa53 boards.
> 
> I would like to test this series on a mx53qsb.
>
> Is the TVE driver available in some git tree?

I have pushed the series for you at:

    git://git.pengutronix.de/git/pza/linux.git imx-ipu-tve/wip

regards
Philipp

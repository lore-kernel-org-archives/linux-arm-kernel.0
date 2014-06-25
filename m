From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 25 Jun 2014 20:53:08 +0800
Subject: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
In-Reply-To: <1403693452.4249.1.camel@weser.hi.pengutronix.de>
References: <20140624153559.GA5741@dragon>
 <CAOMZO5AT54hOF2bi9bQwmBcdtG0QHyofQgoRG6Mw_RpDQXzx=w@mail.gmail.com>
 <20140625062243.GD3242@dragon>
 <CAOMZO5BuOhWo7SCEPFmNRUQBi=5JhDrVv0yvBQM2d_jMyLkbyw@mail.gmail.com>
 <1403693452.4249.1.camel@weser.hi.pengutronix.de>
Message-ID: <20140625125306.GB6917@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 12:50:52PM +0200, Lucas Stach wrote:
> Am Mittwoch, den 25.06.2014, 07:50 -0300 schrieb Fabio Estevam:
> > On Wed, Jun 25, 2014 at 3:22 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > 
> > > Please test against v3.16-rc1 or -rc2.  The breakage on linux-next
> > > should be another issue.
> > 
> > Yes, I see it now. Tested on -rc2 and suspend/resume works with PCI
> > driver removed.
> 
> Can you please send me a dmesg from a working boot?

What do you mean by "working boot"?  Boot is always working.  What fails
is system resuming.

Shawn

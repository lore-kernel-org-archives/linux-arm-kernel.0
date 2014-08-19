From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 19 Aug 2014 22:08:14 +0800
Subject: [PATCH] ARM: dts: imx53-qsrb: Fix suspend/resume
In-Reply-To: <CAOMZO5APoaiR68Coc=idukzCa6Ju9vD5iTu3d9ndBi0vBoj1Jg@mail.gmail.com>
References: <1407434493-22152-1-git-send-email-fabio.estevam@freescale.com>
 <20140808082741.GQ2167@dragon>
 <CAOMZO5APoaiR68Coc=idukzCa6Ju9vD5iTu3d9ndBi0vBoj1Jg@mail.gmail.com>
Message-ID: <20140819140813.GA26734@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 10:18:58AM -0300, Fabio Estevam wrote:
> Hi Shawn,
> 
> On Fri, Aug 8, 2014 at 5:27 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> > On Thu, Aug 07, 2014 at 03:01:33PM -0300, Fabio Estevam wrote:
> >> The following error is seen after a suspend/resume cycle on a mx53qsb with a
> >> MC34708 PMIC:
> ....
> >> Commit 5169df8be0a432ee ("ARM: dts: i.MX53: add support for MCIMX53-START-R")
> >> missed to configure the IOMUX for the PMIC IRQ pin.
> >>
> >> Configure the PMIC IRQ pin so that the suspend/resume sequence behaves cleanly
> >> as expected.
> >>
> >> Cc: <stable@vger.kernel.org> # 3.16
> >> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> >
> > Applied, thanks.
> 
> I haven't seen this applied in your tree yet and nor in the pull
> request you sent for 3.17.

Sorry, Fabio.  The patch got lost by accident.  I just added it back
to imx/fixes branch and it will be in the next batch of fixes for 3.17.

Shawn

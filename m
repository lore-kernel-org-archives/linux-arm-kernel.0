From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 25 Sep 2015 13:59:02 -0700
Subject: [PATCH v5 4/7] pinctrl: freescale: imx: allow mux_reg offset zero
In-Reply-To: <BN3PR03MB150994443644800594BE9BA2A8420@BN3PR03MB1509.namprd03.prod.outlook.com>
References: <1443128043-21063-1-git-send-email-aalonso@freescale.com>
 <1443128043-21063-4-git-send-email-aalonso@freescale.com>
 <20150925104726.GJ11805@pengutronix.de>
 <20150925190725.GX3529@tiger>
 <BN3PR03MB150994443644800594BE9BA2A8420@BN3PR03MB1509.namprd03.prod.outlook.com>
Message-ID: <20150925205902.GZ3529@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2015 at 07:16:49PM +0000, Alonso Adrian wrote:
> > Ah, sorry, I'm screwed on the previous review.  So we still need the flag
> > ZERO_OFFSET_VALID to convert invalid 0 mux_reg to -1.
> > 
> > @Adrian,
> > 
> > Will the following change just work for you?
> @Shawn, yes the change will work, do you want me to prepare a new patch series?

Most of the patches in this series will go to Linus.  So that's his
call, but I suggest you resend.

Shawn

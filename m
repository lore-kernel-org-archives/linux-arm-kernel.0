From: B47053@freescale.com (Xiubo Li-B47053)
Date: Tue, 10 Sep 2013 02:35:34 +0000
Subject: [PATCHv3 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <20130909150346.GV30088@pengutronix.de>
References: <1378454907-22728-1-git-send-email-Li.Xiubo@freescale.com>
 <1378454907-22728-2-git-send-email-Li.Xiubo@freescale.com>
 <20130909122008.GC22197@ulmo> <20130909150346.GV30088@pengutronix.de>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828135D9@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCHv3 1/4] pwm: Add Freescale FTM PWM driver support
> 
> On Mon, Sep 09, 2013 at 02:20:09PM +0200, Thierry Reding wrote:
> > On Fri, Sep 06, 2013 at 04:08:24PM +0800, Xiubo Li wrote:
> > > The FTM PWM device can be found on Vybrid VF610 Tower and Layerscape
> LS-1 SoCs.
> > >
> > > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > > Signed-off-by: Jingchang Lu <b35083@freescale.com>
> > > ---
> > >  drivers/pwm/Kconfig       |  10 +
> > >  drivers/pwm/Makefile      |   1 +
> > >  drivers/pwm/pwm-fsl-ftm.c | 505
> > > ++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 516 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-fsl-ftm.c
> >
> > This looks pretty good to me. I noticed that you didn't Cc Sascha who
> > commented on this a lot. Can you please resend with him Cc'ed to make
> > sure he sees this version of the series?
> 
> I'm already aware of this, no need to resend. I'll have a look over it
> tomorrow.
> 

I'm very sorry, next time I will.


Thanks very much.

--
Best Regards,
Xiubo

From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 Mar 2012 10:45:27 +0100
Subject: [PATCH v4 09/10] pwm: Add PXA support
In-Reply-To: <20120315092134.GA29841@avionic-0098.adnet.avionic-design.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-10-git-send-email-thierry.reding@avionic-design.de>
 <4F61343A.80103@gmail.com>
 <20120315065631.GB20502@avionic-0098.mockup.avionic-design.de>
 <20120315090540.GW3852@pengutronix.de>
 <20120315092134.GA29841@avionic-0098.adnet.avionic-design.de>
Message-ID: <20120315094527.GY3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 10:21:34AM +0100, Thierry Reding wrote:
> * Sascha Hauer wrote:
> > On Thu, Mar 15, 2012 at 07:56:31AM +0100, Thierry Reding wrote:
> > > Actually I wasn't planning on keeping this patch at all. Sascha already has
> > > the existing PWM providers converted to his original framework and offered to
> > > rebase them onto this series once the dust settles. I only used them as
> > > testbed to see how the driver interface works out for different hardware. But
> > > I also think that if Sascha hasn't cleaned the driver up yet it should either
> > > be done in his conversion patches or as follow ups.
> > 
> > All I have is a simple conversion to the new framework, nothing more.  I
> > rebased my patches yesterday onto this series (unfortunately due to the
> > additional argument pwm_device the patches do not look like just moving
> > the drivers anymore). I also skipped the PXA patch since I saw that you
> > already have this one. I just posted the patches to the list.
> 
> Okay, I'll keep my Blackfin and PXA converted drivers then and will fix the
> issues with the PXA driver brought up by Ryan. Would you be okay if I took
> your conversion patches and added them to my series?

Sure, go ahead.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

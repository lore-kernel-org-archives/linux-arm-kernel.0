From: ra7055@freescale.com (Herring Robert-RA7055)
Date: Mon, 19 Apr 2010 06:33:09 -0700
Subject: [RFC PATCH 10/10] mx5: Add MX53 EVK board support
In-Reply-To: <85448.8831.qm@web51003.mail.re2.yahoo.com>
References: <1271446524-26450-11-git-send-email-r.herring@freescale.com>
	<85448.8831.qm@web51003.mail.re2.yahoo.com>
Message-ID: <DE2504B3A515524BBE6934369EFDC0DA0937E201@az33exm20.fsl.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio, 

> -----Original Message-----
> From: Fabio Estevam [mailto:fabioestevam at yahoo.com] 
> Sent: Friday, April 16, 2010 5:15 PM
> To: linux-arm-kernel at lists.infradead.org; 
> s.hauer at pengutronix.de; amit.kucheria at canonical.com; Herring 
> Robert-RA7055
> Cc: Herring Robert-RA7055; u.kleine-koenig at pengutronix.de
> Subject: Re: [RFC PATCH 10/10] mx5: Add MX53 EVK board support
> 
> Rob,
> 
> --- On Fri, 4/16/10, Rob Herring <r.herring@freescale.com> wrote:
> 
> > From: Rob Herring <r.herring@freescale.com>
> > Subject: [RFC PATCH 10/10] mx5: Add MX53 EVK board support
> > To: linux-arm-kernel at lists.infradead.org, 
> s.hauer at pengutronix.de, amit.kucheria at canonical.com
> > Cc: "Rob Herring" <r.herring@freescale.com>
> > Date: Friday, April 16, 2010, 4:35 PM
> > Signed-off-by: Rob Herring <r.herring@freescale.com>
> > ---
> >  arch/arm/mach-mx5/Kconfig? ? ? ?
> > ? |? ? 7 +++
> >  arch/arm/mach-mx5/Makefile? ? ?
> > ???|? ? 1 +
> >  arch/arm/mach-mx5/board-mx53_evk.c |???88
> > ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 96 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-mx5/board-mx53_evk.c
> 
> Shouldn't the name of this file be mach-mx53_evk.c to match 
> the naming convention patches that Uwe sent?

Not when Babbage board is named board-mx51_babbage.c. 

Rob

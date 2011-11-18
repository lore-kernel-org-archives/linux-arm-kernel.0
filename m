From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Fri, 18 Nov 2011 08:57:52 +0000
Subject: [alsa-devel] [PATCH v5 1/3] ARM: mxs: add saif clkmux functions
In-Reply-To: <20166.6019.921262.50184@ipc1.ka-ro>
References: <1321003855-13430-1-git-send-email-b29396@freescale.com>
 <1321003855-13430-2-git-send-email-b29396@freescale.com>
 <201111180554.42242.marek.vasut@gmail.com>
 <65EE16ACC360FA4D99C96DC085B3F7722E47BC@039-SN1MPN1-002.039d.mgd.msft.net>
 <20166.6019.921262.50184@ipc1.ka-ro>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7722E4962@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Lothar Wa?mann [mailto:LW at KARO-electronics.de]
> Sent: Friday, November 18, 2011 4:30 PM
> To: Dong Aisheng-B29396
> Cc: Marek Vasut; alsa-devel at alsa-project.org; s.hauer at pengutronix.de;
> broonie at opensource.wolfsonmicro.com; w.sang at pengutronix.de; Guo Shawn-
> R65073; kernel at pengutronix.de; u.kleine-koenig at pengutronix.de; lrg at ti.com;
> linux-arm-kernel at lists.infradead.org
> Subject: RE: [alsa-devel] [PATCH v5 1/3] ARM: mxs: add saif clkmux
> functions
> 
> Hi,
> 
> Dong Aisheng-B29396 writes:
> [...]
> > > > +#define HW_DIGCTL_CTRL			0x0
> > > > +#define  BP_DIGCTL_CTRL_SAIF_CLKMUX	(10)
> > >
> > > Do you need the parenthesis above ?
> > >
> > I'm not sure about his.
> > HW_DIGCTL_CTRL is the register offset.
> > Do we have to do this?
> >
> You need parens around macro parameters that are used in an expression
> inside the macro. But you never ever need to enclose a bare number in
> parens!
> 
Yep!
I will remove it.
Saving two bytes in code size! :-)

Regards
Dong Aisheng

From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 9 Dec 2010 09:43:58 +0100
Subject: [PATCH v2 08/15] ARM: mxs: Add iomux support
In-Reply-To: <AANLkTimsFBsDu6dKLWPafG5zuAq4BYB1uMGcgEFOYY80@mail.gmail.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-7-git-send-email-shawn.guo@freescale.com>
	<19711.13023.154958.539289@ipc1.ka-ro>
	<AANLkTikb4Ytx==R=n7RDOXv+tKtVvgcTUX7R-QDQfVoc@mail.gmail.com>
	<20101208105643.GO18244@pengutronix.de>
	<AANLkTimHyYUkDqLQ79o9fP_9NgOK1Lec=psoFCpb1+jA@mail.gmail.com>
	<19711.27840.946740.905255@ipc1.ka-ro>
	<AANLkTimsFBsDu6dKLWPafG5zuAq4BYB1uMGcgEFOYY80@mail.gmail.com>
Message-ID: <20101209084358.GR17441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Dec 09, 2010 at 02:15:27PM +0800, Shawn Guo wrote:
> >> Ah, I misunderstood the comments. ?But I did not see mxc switches to
> >> u64. ?Do you have example to show what you want exactly?
> >>
> > See:
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2010-November/032202.html
> >
> Thanks, Lothar.
> 
> Hi Uwe,
> 
> Looking at the page Lothar gave, the patch is to facilitate adding
> platform specific pad_ctrl settings to an
> existing pad definition.  In this case, it might be reasonable to keep
> EXPORT_SYMBOL(mxs_iomux_setup_pad), which you asked me to remove.
> What do you think?
Just don't make it static.  There is no need for EXPORT_SYMBOL.  Ditto
for the multiple variant.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

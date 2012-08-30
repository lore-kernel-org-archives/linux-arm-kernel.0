From: B29397@freescale.com (Chen Peter-B29397)
Date: Thu, 30 Aug 2012 08:47:21 +0000
Subject: MX28 & finding out boot mode
In-Reply-To: <20120830081215.GA1198@shlinux2.ap.freescale.net>
References: <20120830082518.GA27306@pengutronix.de>
 <20120830081215.GA1198@shlinux2.ap.freescale.net>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803C63005@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> > is there a way to find out how the MX28 was booted? I could read out
> the
> > bootmode-pins for indication. Still, either by button or by empty NAND,
> > the CPU could have been booted via USB recovery mode. And going through
> > the docs and the bootlets code, I can't find a way to determine if USB
> > recovery was used.
> >
> > So, can USB recovery mode be detected somehow? Then, this and reading
> > pins should be sufficent, no?
> >
> Add Frank&Peter who may know it.
As far as I know, the romcode decides which mode is used, I haven't read
romcode, so don't know priority of below booting selection.

OTP, button, boot media (if no boot media, will go to USB recovery mode)

Why do you need to know USB recovery mode at your code? 

Peter

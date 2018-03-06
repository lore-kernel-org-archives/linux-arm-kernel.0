From: gabriel.matni@exfo.com (Gabriel Matni)
Date: Tue, 6 Mar 2018 15:39:20 +0000
Subject: [PATCH] serial: mvebu_uart: fix tx lost characters
In-Reply-To: <87lgf663le.fsf@bootlin.com>
References: <3B588D51285A4A4D8D39C94212E0782627008E@SPQCMBX02.exfo.com>
 <20180227141255.177ea751@xps13>
 <3B588D51285A4A4D8D39C94212E07826271B70@SPQCMBX02.exfo.com>
 <20180305104721.311a02c2@xps13> <20180305111012.0ea44d1d@xps13>
 <87lgf663le.fsf@bootlin.com>
Message-ID: <3B588D51285A4A4D8D39C94212E078262748A9@SPQCMBX02.exfo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you Miqu?l and Gregory for your valuable input. I will resubmit the patch with the fixes.

Regards,
Gabriel

> -----Original Message-----
> From: Gregory CLEMENT [mailto:gregory.clement at bootlin.com]
> Sent: March 5, 2018 8:43 AM
> To: Gabriel Matni <gabriel.matni@exfo.com>; Miquel Raynal
> <miquel.raynal@bootlin.com>
> Cc: linux-arm-kernel at lists.infradead.org; gregkh at linuxfoundation.org;
> Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Subject: Re: [PATCH] serial: mvebu_uart: fix tx lost characters
> 
> Hi Gabriel,
> 
>  On lun., mars 05 2018, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Hi Gabriel,
> >
> > On Mon, 5 Mar 2018 10:47:21 +0100, Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> >
> >> Hi Gabriel,
> >>
> >> On Tue, 27 Feb 2018 21:56:03 +0000, Gabriel Matni
> >> <gabriel.matni@exfo.com> wrote:
> >>
> >> > Hi Miqu?l,
> >> >
> >> > > -----Original Message-----
> >> > > From: Miquel Raynal [mailto:miquel.raynal at bootlin.com]
> >> > > Sent: February 27, 2018 8:13 AM
> >> > > To: Gabriel Matni <gabriel.matni@exfo.com>
> >> > > Cc: linux-arm-kernel at lists.infradead.org;
> gregkh at linuxfoundation.org;
> >> > > Gr?gory Clement <gregory.clement@bootlin.com>; Thomas Petazzoni
> >> > > <thomas.petazzoni@bootlin.com>
> >> > > Subject: Re: [PATCH] serial: mvebu_uart: fix tx lost characters
> 
> Given the review done by Miquel and the information you add, you can
> also add my
> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> 
> 
> >
> > BTW, prefix should be "serial: mvebu-uart:".
> >
> > And maybe you should CC: stable too?
> 
> And also adding the following fixes tag:
> 
> Fixes: 30530791a7a0 ("serial: mvebu-uart: initial support for
> Armada-3700 serial port")
> 
> 
> Thanks,
> 
> Gregory
> 
> >
> > Thanks for fixing it anyway.
> > Miqu?l
> 
> --
> Gregory Clement, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> http://bootlin.com

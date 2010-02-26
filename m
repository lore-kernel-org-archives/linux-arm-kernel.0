From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Fri, 26 Feb 2010 12:05:06 +0100
Subject: [PATCH] mx31pdk: Add NAND support
In-Reply-To: <20100226104657.GA8120@pengutronix.de>
References: <1267095523.2722.40.camel@realization>
	<505892.36787.qm@web51002.mail.re2.yahoo.com>
	<20100226093621.GB3088@pengutronix.de>
	<1267179548.2778.41.camel@realization>
	<20100226104657.GA8120@pengutronix.de>
Message-ID: <1267182306.2778.73.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ven, 2010-02-26 at 11:46 +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> > > > MACH name is MX35_3DS and board name is mach-mx35pdk.c
> > > Oh, I must have missed that when massrenaming the machine files.
> > > (commit 321ed164).  Sorry :-)
> > > 
> > > Best regards
> > > Uwe
> > > 
> > 
> > Uwe, so what is the next step? we can re-rename the machine file
> > to mach-mx31pdk.c?
> I suggest to do
> 
> 	mv mach-mx35pdk.c mach-mx35_3ds.c
> 
> to make it consistant.
> 
> Best regards
> Uwe
> 

:) consistant with the MACH name, but the market and freescale call 
these mx[N]pdk, I don't know who registered those names but Fabio 
addressed a not obvious problem.
For me it is not a problem and I think that the motivations are: Freescale
can build different type of Product Development Kit, indeed the 3-Stack
is the particular one -> call it mx[N]_3ds.c
But Freescale do not produce multiple mx[N] PDKs.

Best regards

-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)

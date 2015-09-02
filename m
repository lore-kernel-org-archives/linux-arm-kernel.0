From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Wed, 2 Sep 2015 10:40:19 +0300
Subject: ARM: pxa: build error in arch/arm/plat-pxa/ssp.c
In-Reply-To: <20150901184335.GY5313@sirena.org.uk>
References: <1441073073.12012.3.camel@ingics.com>
 <55E54754.1060002@linux.intel.com>
 <20150901184335.GY5313@sirena.org.uk>
Message-ID: <20150902074019.GE1609@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 01, 2015 at 07:43:35PM +0100, Mark Brown wrote:
> > What I'm wondering is this binding below correct in arch/arm/plat-pxa/ssp.c?
> > LPSS_SSP was meant to be for Intel Intel Low Power Subsystem SPI.
> 
> > "{ .compatible = "mrvl,lpss-ssp",	.data = (void *) LPSS_SSP }"
> 
> > Mika, Daniel: do you know is there any change there is a Marvell PXA
> > platform compatible with Intel LPSS or is above binding bogus?
> 
> I bet it's just cut'n'paste because everything else about the driver and
> all the DT is for Marvell stuff.

I agree.

That entry definitely should not be there.

From: greg@kroah.com (Greg KH)
Date: Wed, 16 May 2012 05:48:51 -0700
Subject: linux-next: manual merge of the arm-soc tree with the staging tree
In-Reply-To: <201205161054.15610.arnd@arndb.de>
References: <20120516185812.ce1ab57c3ec72445135a35fc@canb.auug.org.au>
 <201205161054.15610.arnd@arndb.de>
Message-ID: <20120516124851.GA32064@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 10:54:15AM +0000, Arnd Bergmann wrote:
> On Wednesday 16 May 2012, Stephen Rothwell wrote:
> > Today's linux-next merge of the arm-soc tree got a conflict in
> > arch/arm/boot/dts/at91sam9g20.dtsi between commit 7cb2e629a240 ("ARM:
> > AT91: Add ADC driver to the at91sam9g20 dtsi") from the staging tree and
> > commit 5b6089cb6f28 ("ARM: at91: add at91sam9260 DT support") from the
> > arm-soc tree.
> > 
> > So, I didn't know what to do with this, so I used the arm-soc version of
> > this file (effectively throwing away the staging tree change).  Hints,
> > anyone?
> 
> I suspect the addition of the adc node should just go into the
> at91sam9260.dtsi file.

So does that mean that the staging tree version is correct?  Or that
someone needs to send me a fixup patch here?

confused,

greg k-h

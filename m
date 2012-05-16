From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 May 2012 10:54:15 +0000
Subject: linux-next: manual merge of the arm-soc tree with the staging tree
In-Reply-To: <20120516185812.ce1ab57c3ec72445135a35fc@canb.auug.org.au>
References: <20120516185812.ce1ab57c3ec72445135a35fc@canb.auug.org.au>
Message-ID: <201205161054.15610.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 May 2012, Stephen Rothwell wrote:
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/boot/dts/at91sam9g20.dtsi between commit 7cb2e629a240 ("ARM:
> AT91: Add ADC driver to the at91sam9g20 dtsi") from the staging tree and
> commit 5b6089cb6f28 ("ARM: at91: add at91sam9260 DT support") from the
> arm-soc tree.
> 
> So, I didn't know what to do with this, so I used the arm-soc version of
> this file (effectively throwing away the staging tree change).  Hints,
> anyone?

I suspect the addition of the adc node should just go into the
at91sam9260.dtsi file.

	Arnd

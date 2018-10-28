From: jic23@jic23.retrosnub.co.uk (Jonathan Cameron)
Date: Sun, 28 Oct 2018 15:40:11 +0000
Subject: [PATCH v5 04/11] dt-bindings: iio: adc: add AXP803 ADC bindings
In-Reply-To: <20181024135633.GA342@bogus>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-5-oskari@lemmela.net>
 <20181024135633.GA342@bogus>
Message-ID: <20181028154011.04efdecf@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Oct 2018 08:56:33 -0500
Rob Herring <robh@kernel.org> wrote:

> On Tue, 23 Oct 2018 21:53:23 +0300, Oskari Lemmela wrote:
> > The AXP803 ADC is compatible with AXP813 ADC, but add
> > specific compatible for it.
> > 
> > Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

This doesn't seem to have any dependencies with the other patches
so applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to ignore.  However I am a little curious to know
why we would add the ID and then not use it (that I can see)?

Thanks,

Jonathan

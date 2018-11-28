From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 Nov 2018 09:31:11 +0000
Subject: [PATCH 07/14] dt-bindings: mfd: axp20x: Add software based
 soft_start for AXP209 LDO3
In-Reply-To: <20181126165822.GJ9715@sirena.org.uk>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <2cd75ee27982f3be0d86104d80eaa13efeb2c65d.1543245984.git-series.plaes@plaes.org>
 <20181126165822.GJ9715@sirena.org.uk>
Message-ID: <20181128093111.GZ4272@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 26 Nov 2018, Mark Brown wrote:

> On Mon, Nov 26, 2018 at 05:27:48PM +0200, Priit Laes wrote:
> 
> > +- regulator-soft-start:	enable the output at the lowest possible voltage and
> > +			only then set the desired voltage
> > +			AXP20x/LDO3
> 
> This is a generic property, there is no need to document it in each
> device binding.

It's not unwelcome here though.

Particularly with such a nicely written up commit messages.

I'll leave it up to you, but it's fine by me.

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

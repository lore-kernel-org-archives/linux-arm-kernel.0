From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Wed, 21 Feb 2018 21:26:50 +0900
Subject: [PATCH 1/2] ASoC: add DT bindings documentation for ROHM BD28623
 codec
In-Reply-To: <20180221121354.GG8334@sirena.org.uk>
References: <20180221043311.25840-1-suzuki.katsuhiro@socionext.com>
 <20180221043311.25840-2-suzuki.katsuhiro@socionext.com>
 <20180221121354.GG8334@sirena.org.uk>
Message-ID: <001801d3ab0f$3fe07490$bfa15db0$@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

Thank you for your review.

> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: Wednesday, February 21, 2018 9:14 PM
> To: Suzuki, Katsuhiro <suzuki.katsuhiro@socionext.com>
> Cc: alsa-devel at alsa-project.org; Rob Herring <robh+dt@kernel.org>; devicetree at vger.kernel.org; Masami Hiramatsu
> <masami.hiramatsu@linaro.org>; Jassi Brar <jaswinder.singh@linaro.org>; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 1/2] ASoC: add DT bindings documentation for ROHM BD28623 codec
> 
> On Wed, Feb 21, 2018 at 01:33:10PM +0900, Katsuhiro Suzuki wrote:
> 
> > +Optional properties:
> > +- VCCA-supply : regulator phandle for the VCCA supply
> > +- VCCP1-supply: regulator phandle for the VCCP1 supply
> > +- VCCP2-supply: regulator phandle for the VCCP2 supply
> 
> These should be documented as mandatory unless the device genuinely
> operates without power which seems unlikely.

Indeed, this IC does not work correctly if VCC power supply is lost.
It's not optional. I'll fix it and send V2.


Regards,
--
Katsuhiro Suzuki

From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Tue, 12 Dec 2017 13:33:34 +0900
Subject: [alsa-devel] [PATCH 5/8] ASoC: uniphier: add support for UniPhier
 AIO driver
In-Reply-To: <20171211174854.GZ18649@localhost>
References: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
 <20171122114321.29196-6-suzuki.katsuhiro@socionext.com>
 <20171204183934.rd4vin22ktukwpip@sirena.org.uk>
 <002b01d36d84$51d80aa0$f5881fe0$@socionext.com>
 <20171205121440.GC11658@finisterre>
 <004801d36e57$ea1940d0$be4bc270$@socionext.com>
 <20171206125817.GF1827@finisterre>
 <001501d37261$7ea89d10$7bf9d730$@socionext.com>
 <20171211151629.GD9854@sirena.org.uk> <20171211174854.GZ18649@localhost>
Message-ID: <003201d37302$5f40fde0$1dc2f9a0$@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vinod, Mark,

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Tuesday, December 12, 2017 2:49 AM
> To: Mark Brown <broonie@kernel.org>
> Cc: Suzuki, Katsuhiro/?? ?? <suzuki.katsuhiro@socionext.com>;
> devicetree at vger.kernel.org; alsa-devel at alsa-project.org; Masami Hiramatsu
> <masami.hiramatsu@linaro.org>; Yamada, Masahiro/?? ??
> <yamada.masahiro@socionext.com>; linux-kernel at vger.kernel.org; Jassi Brar
> <jaswinder.singh@linaro.org>; Rob Herring <robh+dt@kernel.org>;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [alsa-devel] [PATCH 5/8] ASoC: uniphier: add support for UniPhier
> AIO driver
> 
> On Mon, Dec 11, 2017 at 03:16:29PM +0000, Mark Brown wrote:
> > On Mon, Dec 11, 2017 at 06:21:58PM +0900, Katsuhiro Suzuki wrote:
> >
> > > But I can't find how to use/map this DAI in machine driver or Device-Tree
or
> > > something. I think that it's same as PCM DAI, am I correct?
> >
> > Yes, that probably makes sense from a binding point of view.
> >
> > > I read compress-offload.rst, but I can't find how do I test it. It seems
aplay
> > > of
> > > alsa-util doesn't know compress audio formats. Should I use PulseAudio or
> > > Android HAL to test compress audio APIs?
> >
> > IIRC tinyalsa has a compressed API test application - Vinod?
> 
> I guess it was sheer luck that i saw this :) email in CC reads
> vinod.koul at linaro.org! I don't work for Linaro, not yet :D
> 
> And to the answer the question, Yes we have compressed API test application
> in tinycompress which is located at git.alsa-project.org:tinycompress.git
> 
> We have both compressed audio playback as well as record test app, cplay and
> crecord.
> 

Ah, I didn't check tinyalsa, thanks a lot!
I'll try it.


Regards,
--
Katsuhiro Suzuki


> HTH
> --
> ~Vinod

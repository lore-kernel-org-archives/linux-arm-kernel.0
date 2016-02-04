From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Thu, 4 Feb 2016 13:28:57 +0000
Subject: [PATCH v4 1/2] regulator: act8945a: add regulator driver for
 ACT8945A
In-Reply-To: <20160203174753.GJ4455@sirena.org.uk>
References: <1453863463-30515-1-git-send-email-wenyou.yang@atmel.com>
 <1453863463-30515-2-git-send-email-wenyou.yang@atmel.com>
 <20160129001603.GM4130@sirena.org.uk>
 <B256D81BAE5131468A838E5D7A243641D63FBF8B@penmbx01>
 <20160129113518.GQ4130@sirena.org.uk>
 <CABxcv=kNKmgRytxB5ppawrAvC-GDRhV4T_UUGvpHgKp9+BsUmQ@mail.gmail.com>
 <B256D81BAE5131468A838E5D7A243641D63FE2C7@penmbx01>
 <CABxcv=nJsWEv9KW-5iPpUnyN8ZVpx6CV07gBRaLNWqd644YOqQ@mail.gmail.com>
 <B256D81BAE5131468A838E5D7A243641D64026CB@penmbx01>
 <20160203174753.GJ4455@sirena.org.uk>
Message-ID: <B256D81BAE5131468A838E5D7A243641D64062A0@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: 2016?2?4? 1:48
> To: Yang, Wenyou <Wenyou.Yang@atmel.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>; Liam Girdwood
> <lgirdwood@gmail.com>; Rob Herring <robh+dt@kernel.org>; Pawel Moll
> <pawel.moll@arm.com>; Ian Campbell <ijc+devicetree@hellion.org.uk>; Kumar
> Gala <galak@codeaurora.org>; Krzysztof Kozlowski
> <k.kozlowski@samsung.com>; Lee Jones <lee.jones@linaro.org>; Peter
> Korsgaard <jacmet@gmail.com>; Ferre, Nicolas <Nicolas.FERRE@atmel.com>;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH v4 1/2] regulator: act8945a: add regulator driver for
> ACT8945A
> 
> On Wed, Feb 03, 2016 at 02:33:11AM +0000, Yang, Wenyou wrote:
> 
> > > I would just remove the "active-semi,act8945a-regulator" node and
> > > make "active- semi,vsel-high" a property of the "active-semi,act8945a" node.
> > > That way you can remove the mfd cell .of_compatible and OF table in
> > > the regulator driver and read the "active-semi,vsel-high" using the
> > > platform device's parent of_node.
> 
> > > But it's better if you wait for Mark's opinions before re-spining your patches.
> 
> > Hi Mark, what is your opinions?
> 
> Like Javier says you should make your DT binding look like the DT bindings for
> other MFDs and not use of_compatible.

All right.

Thank you, Mark, Javier.


Best Regards,
Wenyou Yang

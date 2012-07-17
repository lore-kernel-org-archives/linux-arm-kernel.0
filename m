From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 17 Jul 2012 14:10:37 +0100
Subject: linux-next: manual merge of the arm-soc tree with the
 i2c-embedded tree
In-Reply-To: <20120716123550.GE17435@pengutronix.de>
References: <20120710164130.f38e4d1673f925ddb13914c9@canb.auug.org.au>
 <20120712131231.GH2194@pengutronix.de>
 <CACRpkdboeF_G=sTPeSyuZ6KGLCmGSKx_NS=6Rim6HkR2f9=AAQ@mail.gmail.com>
 <20120716101706.GB17435@pengutronix.de>
 <CACRpkdY626iYATorphAvg7cQxD2ufysBvXdt3Z644zEuW0wS=w@mail.gmail.com>
 <20120716123550.GE17435@pengutronix.de>
Message-ID: <20120717131037.GC27595@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2012 at 02:35:50PM +0200, Wolfram Sang wrote:

> I do know both sides. I easily agree that we have to find a balance
> somewhere to meet both interests. Though, currently my impressions from
> maintaining I2C are:

> a) it is not balanced, but too far on the "let's deploy stuff" side
> b) developers have a tendency to simply map platform_data to bindings
>    and are surprised when told this is often not possible

> which adds burden to the maintainers (who sometimes might not even be
> familiar with devicetree because they are not focused on embedded). And
> I worry about bindings of unmaintained subsystems.

A issue I'm seeing with some of the subsystems mantained by people who
don't work on ARM is that they've got the DT message so strongly that
they're pushing back on people trying to add platform data at all even
on off SoC things that need to work with non-ARM processors.

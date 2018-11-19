From: aford173@gmail.com (Adam Ford)
Date: Mon, 19 Nov 2018 14:29:15 -0600
Subject: [PATCH] Support RTC charging on PFUZE100
In-Reply-To: <20181114222528.GE2089@sirena.org.uk>
References: <20181030143718.10027-1-aford173@gmail.com>
 <20181114222528.GE2089@sirena.org.uk>
Message-ID: <CAHCN7xJMu0nwCKfRMVEQTkYRRx6z9h44-NdAgeD403D195SuaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2018 at 4:25 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Oct 30, 2018 at 09:37:18AM -0500, Adam Ford wrote:
> >
> > diff --git a/arch/arm/boot/dts/imx6-logicpd-som.dtsi b/arch/arm/boot/dts/imx6-logicpd-som.dtsi
> > index 1e5dcac70045..74ab5d65106b 100755
> > --- a/arch/arm/boot/dts/imx6-logicpd-som.dtsi
> > +++ b/arch/arm/boot/dts/imx6-logicpd-som.dtsi
>
> > diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
> > index 659e516455be..bdef74077d1c 100644
> > --- a/drivers/regulator/pfuze100-regulator.c
> > +++ b/drivers/regulator/pfuze100-regulator.c
>
> Please follow the patch submission process covered in
> submitting-patchest.rst.  You've not included a Signed-off-by which is
> essential for legal reasons as covered in there and this is a single
> patch which mixes a DT change and a regulator driver change which should
> be in separate patches.

Mark,

I think you're looking at the V1 patch.  This was replaced by a V2
patch:  https://patchwork.kernel.org/patch/10661227/

It should have a S-o-b line.  I know I sent it to the wrong mailing
list (per your other e-mail to me) , so if you want it re-mailed, I
can do that.

thank you,

adam

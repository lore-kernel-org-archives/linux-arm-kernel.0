From: nicoleotsuka@gmail.com (Nicolin Chen)
Date: Tue, 30 Sep 2014 13:37:57 -0700
Subject: [PATCH] ASoC: fsl: fix dependencies for wm8962
In-Reply-To: <CAOMZO5AZri8dofH6-Bqqj64_itu-W6nUEi5W5koGnQCqqVpbfw@mail.gmail.com>
References: <1950588.ErdGoiHh8p@wuerfel> <20140930164510.GF4273@sirena.org.uk>
 <CAOMZO5B3LztUdafDCo8bzLwbmeBB3N-rpQLxXMvb0pXgtGVugA@mail.gmail.com>
 <20140930194340.GA13318@Alpha>
 <CAOMZO5AZri8dofH6-Bqqj64_itu-W6nUEi5W5koGnQCqqVpbfw@mail.gmail.com>
Message-ID: <20140930203756.GA13613@Alpha>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 04:48:01PM -0300, Fabio Estevam wrote:
> >> -       select SND_SOC_CS42XX8_I2C
> >> -       select SND_SOC_SGTL5000
> >> -       select SND_SOC_WM8962
> >
> > Okay..if Mark means this...I think it makes sense to me now.
> >
> > But in this case, we shall add them into imx_v6_v7_defconfig instead.
> 
> We already have
> CONFIG_SND_SOC_IMX_WM8962=y
> CONFIG_SND_SOC_IMX_SGTL5000=y
> 
> in imx_v6_v7_defconfig.

Yea, and these are two things I plan to drop...

So when enabling the FSL_ASOC_CARD, I also needs to put those three
into it as well.

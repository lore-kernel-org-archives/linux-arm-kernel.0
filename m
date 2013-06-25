From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 25 Jun 2013 21:04:18 +0800
Subject: [PATCH 2/2] ARM: dts: mx28: Fix sgtl5000 codec probe
In-Reply-To: <20130625125240.GC12178@S2101-09.ap.freescale.net>
References: <CAOMZO5DYNmiasRREC8jXH===2HG1aNvpxpFVU2u+q5ZAT8Wd3Q@mail.gmail.com>
 <20130624072908.GH26254@S2101-09.ap.freescale.net>
 <CAOMZO5Bfetjwinatj4W-nrEvg+3pLfjgF8Zpx_-=n52ZTGHeGA@mail.gmail.com>
 <20130624140754.GF30747@S2101-09.ap.freescale.net>
 <CAOMZO5Ds3ZBhunOh1BSjLz7g=-3mRz_CwpgsPVnabGr=XzMx4g@mail.gmail.com>
 <20130625081227.GA12178@S2101-09.ap.freescale.net>
 <CAOMZO5Ch+kp4kzc_-aghZz3yMeXYYsKXiiaFrxVJnYF+BCFTbA@mail.gmail.com>
 <20130625121941.GB12178@S2101-09.ap.freescale.net>
 <CAOMZO5Cy4v7JCNa9aMhKdHKvNTaXmKp_jvTP-Nau7T1SgB4P1g@mail.gmail.com>
 <20130625125240.GC12178@S2101-09.ap.freescale.net>
Message-ID: <20130625130416.GA31488@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 08:52:42PM +0800, Shawn Guo wrote:
> On Tue, Jun 25, 2013 at 09:22:10AM -0300, Fabio Estevam wrote:
> > On Tue, Jun 25, 2013 at 9:19 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > 
> > > It seems to me that it fails at sgtl5000_fill_defaults().  Did you
> > > test it on imx28 when your commit af8ee11 (ASoC: sgtl5000: Fix driver probe
> > > after reset) goes in?
> > 
> > I am running linux-next, which contains af8ee11.
> 
> What I'm saying is why you are seeing error "snd_soc_register_card
> failed (-517)" on the second attempt is just because of commit af8ee11.
> IOW, I doubt you did not test commit af8ee11 on imx28 when you was

s/doubt/guess

Shawn

> submitting the patch.

From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 26 May 2015 16:29:03 +0800
Subject: [PATCH 2/2] pwm: add Mediatek display PWM driver support
In-Reply-To: <20150526060533.GW6325@pengutronix.de>
References: <1431336382-13167-1-git-send-email-yh.huang@mediatek.com>
 <1431336382-13167-3-git-send-email-yh.huang@mediatek.com>
 <CAGS+omBX1fMBHa-4GLTjQUq5VPR2JRvhJRJ4qBX8hvDF9ihbLA@mail.gmail.com>
 <1432196551.15653.2.camel@mtksdaap41>
 <20150526060533.GW6325@pengutronix.de>
Message-ID: <1432628943.11070.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-05-26 at 08:05 +0200, Sascha Hauer wrote:
> On Thu, May 21, 2015 at 04:22:31PM +0800, YH Huang wrote:
> > On Mon, 2015-05-18 at 11:42 +0800, Daniel Kurtz wrote:
<...>
> > > On Mon, May 11, 2015 at 5:26 PM, YH Huang <yh.huang@mediatek.com> wrote:
> > > > +
> > > > +static const struct of_device_id mtk_disp_pwm_of_match[] = {
> > > > +       { .compatible = "mediatek,mt6595-disp-pwm" },
> > > 
> > > Does this driver support the PWM in mt8173?
> > > If so, don't you need this, too:
> > > 
> > >   { .compatible = "mediatek,mt8173-disp-pwm" },
> > 
> > Yes, it supports mt8173.
> > I will add it.
> 
> If both yre compatible you don't need to add it since you have a
> "mediatek,mt6595-disp-pwm" in the mt8173 device tree.

Hi Sascha,

We got a similar discussion about this with Mark Brown for spi driver,
please see:

http://lists.infradead.org/pipermail/linux-mediatek/2015-May/000673.html

Joe.C

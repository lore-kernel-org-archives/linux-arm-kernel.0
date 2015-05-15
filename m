From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Thu, 14 May 2015 20:12:51 -0700
Subject: [PATCH 05/10] pinctrl: mediatek: Add Pinctrl/GPIO driver for
 mt6397.
In-Reply-To: <20150514072228.GB20358@x1>
References: <1431567346-33780-1-git-send-email-hongzhou.yang@mediatek.com>
 <1431567346-33780-6-git-send-email-hongzhou.yang@mediatek.com>
 <20150514072228.GB20358@x1>
Message-ID: <1431659571.35701.2.camel@mussux00.eus.mediatek.inc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-05-14 at 08:22 +0100, Lee Jones wrote:
> On Wed, 13 May 2015, Hongzhou Yang wrote:
> 
> > Add mt6397 support using mediatek common pinctrl driver.
> > 
> > mt6397 is a PMIC, and pinctrl/GPIO is part of 6397 chip.
> > Pinctrl/GPIO driver should obtain regmap from PMIC,
> > so adding this support to common code.
> > 
> > Also, mt6397 is no need to support interrupt controller,
> > so changing common code to skip it.
> > 
> > Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> > ---
> >  drivers/mfd/mt6397-core.c                     |    3 +
> 
> Please break this out into a separate patch that I can take through my
> tree.  There is no need for you to bind up changes in multiple
> subsystems here.

Ok, I will separate it, thank you.

Yours,
Hongzhou

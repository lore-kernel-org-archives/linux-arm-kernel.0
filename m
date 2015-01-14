From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 14 Jan 2015 10:33:01 +0800
Subject: [PATCH v4 1/5] ARM: mediatek: Add config options for mediatek
 SoCs.
In-Reply-To: <CACRpkda2pHpjMAsEeuEebShQnbqf5knfNbEGtSHLN=o18HC5nQ@mail.gmail.com>
References: <1418772873-19747-1-git-send-email-hongzhou.yang@mediatek.com>
 <1418772873-19747-2-git-send-email-hongzhou.yang@mediatek.com>
 <CACRpkda2pHpjMAsEeuEebShQnbqf5knfNbEGtSHLN=o18HC5nQ@mail.gmail.com>
Message-ID: <1421202781.27675.149.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-01-13 at 10:43 +0100, Linus Walleij wrote:
> On Wed, Dec 17, 2014 at 12:34 AM, Hongzhou Yang
> <hongzhou.yang@mediatek.com> wrote:
> 
> > From: Yingjoe Chen <yingjoe.chen@mediatek.com>
> >
> > The upcoming MTK pinctrl driver have a big pin table for each SoC
> > and we don't want to bloat the kernel binary if we don't need it.
> > Add config options so we can build for one SoC only.
> >
> > Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I guess this goes directly to the ARM SoC tree. As it is only
> Kconfig symbols it should be OK to merge out-of-order.
> 

Hi Matthias,

Since this one is in arch/arm/mach-mediatek, can you take it?

Links for original post in case you can't find it.
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/311181.html

Joe.C

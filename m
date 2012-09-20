From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 21 Sep 2012 07:13:33 +0900
Subject: [PATCH 0/6] pinctrl: samsung: Various fixes
In-Reply-To: <2771354.x9C40TPfJ1@amdc1227>
References: <1348131104-24828-1-git-send-email-t.figa@samsung.com>
 <CACRpkdbTPQvGSHJU_odGFtr5snb=U+L2Yuo-AhgX55hF6V5Lqw@mail.gmail.com>
 <505B2839.1040600@samsung.com> <2771354.x9C40TPfJ1@amdc1227>
Message-ID: <0abf01cd977d$2c9dfcf0$85d9f6d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Hi Kukjin,
> 
Hi,

> On Thursday 20 of September 2012 23:29:13 Kukjin Kim wrote:
> > On 09/20/12 19:25, Linus Walleij wrote:
> > > On Thu, Sep 20, 2012 at 10:51 AM, Tomasz Figa<t.figa@samsung.com>
> wrote:
> > >> This patch series contains various fixes of problems and nitpicks
> > >> spotted when working on adding support for Exynos4x12. See each patch
> > >> for more detailed information.
> > >
> > > This all looks good, do you want me to take this into the pinctrl tree
> > > or will it go through Samsung ARM SoC (Kyungmin)?
> > >
> > > In the latter case, Acked-by: Linus Walleij<linus.walleij@linaro.org>
> > > for all, else poke me and I'll apply them.
> >
> > Linus, thanks for your ack and looks OK to me. Since now pinctrl-exynos
> > driver is in my tree so let me pick this series on top of it into
> > Samsung tree with your ack.
> 
> I just posted an additional last minute trivial patch which fixes another
> typo I found.
> 
> Could you take it with this series?
> 
Sure, your "[PATCH 7/6] pinctrl: exynos: Fix wakeup IRQ domain registration
check" is correct. I will pick that up with this series.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

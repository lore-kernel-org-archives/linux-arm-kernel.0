From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 8 Jan 2015 10:59:41 +0800
Subject: [PATCH v3 3/4] clk: mediatek: Add basic clocks for Mediatek
 MT8135.
In-Reply-To: <CABuKBeJGpYRT6XKM--H80u=cWpE5k97wdsSzWz4sTOwp33yCDQ@mail.gmail.com>
References: <1420601123-25859-1-git-send-email-jamesjj.liao@mediatek.com>
 <1420601123-25859-4-git-send-email-jamesjj.liao@mediatek.com>
 <CABuKBeJGpYRT6XKM--H80u=cWpE5k97wdsSzWz4sTOwp33yCDQ@mail.gmail.com>
Message-ID: <1420685981.27952.49.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Wed, 2015-01-07 at 18:31 +0100, Matthias Brugger wrote:
> 2015-01-07 4:25 GMT+01:00 James Liao <jamesjj.liao@mediatek.com>:
> > +++ b/drivers/clk/Makefile
> > @@ -47,6 +47,7 @@ obj-$(CONFIG_ARCH_HI3xxx)             += hisilicon/
> >  obj-$(CONFIG_ARCH_HIP04)               += hisilicon/
> >  obj-$(CONFIG_ARCH_HIX5HD2)             += hisilicon/
> >  obj-$(CONFIG_COMMON_CLK_KEYSTONE)      += keystone/
> > +obj-$(CONFIG_ARCH_MEDIATEK)            += mediatek/
> 
> This should be part of patch 2 instead of 3.
> 
> > +++ b/drivers/clk/mediatek/Makefile
> > @@ -0,0 +1,2 @@
> > +obj-y += clk-mtk.o clk-pll.o clk-gate.o
> 
> This should be in patch 2 instead of 3.

OK. I'll separate common codes and platform codes in next patch.


Best regards,

James

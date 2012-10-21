From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 21 Oct 2012 18:25:19 +0200
Subject: [PATCH] ARM: dts: exynos4: Enable serial controllers on Origen
 and SMDKV310
In-Reply-To: <10e401cdaae0$a17d44b0$e477ce10$%kim@samsung.com>
References: <1349701968-6675-1-git-send-email-t.figa@samsung.com>
 <1587144.mixS1B3zoJ@amdc1227>
 <10e401cdaae0$a17d44b0$e477ce10$%kim@samsung.com>
Message-ID: <16890730.oeOgcP5xf2@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

On Monday 15 of October 2012 23:23:22 Kukjin Kim wrote:
> Tomasz Figa wrote:
> > Hi Kgene,
> > 
> > On Monday 08 of October 2012 15:12:48 Tomasz Figa wrote:
> > > This patch adds status override of serial nodes to enable used
> > > serial
> > > ports on Origen and SMDKV310 board.
> > > 
> > > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > > ---
> > > 
> > >  arch/arm/boot/dts/exynos4210-origen.dts   | 16 ++++++++++++++++
> > >  arch/arm/boot/dts/exynos4210-smdkv310.dts | 16 ++++++++++++++++
> > >  2 files changed, 32 insertions(+)
> > 
> > I think you missed this patch when applying Exynos dts reorganization
> > patches. It is needed to enable serial ports on Origen and SMDKV310
> 
> boards.
> 
> > Could you apply it as well?
> 
> Oops, yeah. I will apply.

I saw that you applied this patch to your next/dt-samsung branch, thanks.

However I think this should be considered a fix, because without it serial 
console on Origen and SMDKV310 will be broken.

Best regards,
Tomasz Figa

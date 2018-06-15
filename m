From: honghui.zhang@mediatek.com (Honghui Zhang)
Date: Fri, 15 Jun 2018 10:47:55 +0800
Subject: [PATCH v3] PCI: mediatek: Add system pm support for MT2712
In-Reply-To: <CAHp75VcEp2kFO4hncvMS4Dh1AzvoFbrps7+FLmdk0RLyNTHz7g@mail.gmail.com>
References: <1527822270-30280-1-git-send-email-honghui.zhang@mediatek.com>
 <CAHp75VeBTmC=3nJ-t+OO9bp0mzJuTYsGBwi8fokT16bu2nE9RA@mail.gmail.com>
 <1527850145.28160.6.camel@mhfsdcap03>
 <CAHp75VcEp2kFO4hncvMS4Dh1AzvoFbrps7+FLmdk0RLyNTHz7g@mail.gmail.com>
Message-ID: <1529030875.28160.10.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-06-01 at 13:52 +0300, Andy Shevchenko wrote:
> On Fri, Jun 1, 2018 at 1:49 PM, Honghui Zhang
> <honghui.zhang@mediatek.com> wrote:
> > On Fri, 2018-06-01 at 13:17 +0300, Andy Shevchenko wrote:
> >> On Fri, Jun 1, 2018 at 6:04 AM,  <honghui.zhang@mediatek.com> wrote:
> >> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> >>
> >> > +#ifdef CONFIG_PM_SLEEP
> >> > +static int mtk_pcie_suspend_noirq(struct device *dev)
> >>
> >> __maybe_unused
> >>
> >
> > Hi, Andy, thanks for your review.
> > Bjorn had point this out that at:
> > https://www.spinics.net/lists/arm-kernel/msg656774.html
> 
> Nice, one more maintainer with strong opinion here.
> 
> Arnd, that's what I mentioned as a split in opinions earlier.
> Any new developer or even existing contributor would be now really
> confusing since maintainers asked for two different approaches on the
> same matter.
> 

Hi, Arnd, Do you have any comments about this patch? Sorry I missed the
previous discussion about which should be used for this approach.

thanks.

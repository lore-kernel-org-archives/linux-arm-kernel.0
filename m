From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 1 Jun 2018 13:52:44 +0300
Subject: [PATCH v3] PCI: mediatek: Add system pm support for MT2712
In-Reply-To: <1527850145.28160.6.camel@mhfsdcap03>
References: <1527822270-30280-1-git-send-email-honghui.zhang@mediatek.com>
 <CAHp75VeBTmC=3nJ-t+OO9bp0mzJuTYsGBwi8fokT16bu2nE9RA@mail.gmail.com>
 <1527850145.28160.6.camel@mhfsdcap03>
Message-ID: <CAHp75VcEp2kFO4hncvMS4Dh1AzvoFbrps7+FLmdk0RLyNTHz7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 1, 2018 at 1:49 PM, Honghui Zhang
<honghui.zhang@mediatek.com> wrote:
> On Fri, 2018-06-01 at 13:17 +0300, Andy Shevchenko wrote:
>> On Fri, Jun 1, 2018 at 6:04 AM,  <honghui.zhang@mediatek.com> wrote:
>> > From: Honghui Zhang <honghui.zhang@mediatek.com>
>>
>> > +#ifdef CONFIG_PM_SLEEP
>> > +static int mtk_pcie_suspend_noirq(struct device *dev)
>>
>> __maybe_unused
>>
>
> Hi, Andy, thanks for your review.
> Bjorn had point this out that at:
> https://www.spinics.net/lists/arm-kernel/msg656774.html

Nice, one more maintainer with strong opinion here.

Arnd, that's what I mentioned as a split in opinions earlier.
Any new developer or even existing contributor would be now really
confusing since maintainers asked for two different approaches on the
same matter.

-- 
With Best Regards,
Andy Shevchenko

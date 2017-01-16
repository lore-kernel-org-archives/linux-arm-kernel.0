From: honghui.zhang@mediatek.com (Honghui Zhang)
Date: Mon, 16 Jan 2017 10:48:50 +0800
Subject: [PATCH v4 5/5] ARM: dts: mt2701: add iommu/smi dtsi node for
 mt2701
In-Reply-To: <5a45da57-9262-b1ff-1c6a-c5c211c1bfd4@gmail.com>
References: <1465379461-14757-1-git-send-email-honghui.zhang@mediatek.com>
 <1465379461-14757-6-git-send-email-honghui.zhang@mediatek.com>
 <09eaf7a5-2b18-1ea6-5699-2e968c6b79a4@gmail.com>
 <51441f39-e5b5-2cce-63ab-47bd3cf298b3@gmail.com>
 <1467595950.8420.2.camel@mtksdaap41> <577A1794.5040509@gmail.com>
 <5a45da57-9262-b1ff-1c6a-c5c211c1bfd4@gmail.com>
Message-ID: <1484534930.27576.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-01-13 at 15:54 +0100, Matthias Brugger wrote:
> 
> On 04/07/16 10:00, Matthias Brugger wrote:
> >
> >
> > On 04/07/16 03:32, Honghui Zhang wrote:
> >> On Sun, 2016-07-03 at 21:12 +0200, Matthias Brugger wrote:
> >>>
> >>> On 07/03/2016 08:24 AM, Matthias Brugger wrote:
> >>>>
> >>>>
> >>>> On 06/08/2016 11:51 AM, honghui.zhang at mediatek.com wrote:
> >>>>> From: Honghui Zhang <honghui.zhang@mediatek.com>
> >>>>>
> >>>>> Add the dtsi node of iommu and smi for mt2701.
> >>>>>
> >>>>> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> >>>>> ---
> >>>>>   arch/arm/boot/dts/mt2701.dtsi | 51
> >>>>> +++++++++++++++++++++++++++++++++++++++++++
> >>>>>   1 file changed, 51 insertions(+)
> >>>>>
> >>>>
> >>>> Applied,
> >>>
> >>> Please resend the patch including the infracfg and mmsys node.
> >>>
> >>
> >> Hi, Matthias,
> >>
> >> Please hold this one.
> >> This one is based on CCF "arm: dts: mt2701: Add clock controller device
> >> nodes"[1] and power domain patch "Mediatek MT2701 SCPSYS power domain
> >> support v7"[2],
> >> But these two patchset are still being reviewed now.
> >>
> >> Do you think it's better that I send this one later after ccf and power
> >> domain patch got merged? I will send this patch later if it's OK with
> >> you.
> >>
> >
> > Sounds good.
> 
> Applied now to v4.10-next/dts32
> 
> Thanks.
> 

Thanks.

> >
> > Thanks a lot,
> > Matthias
> >
> >> Thanks.
> >> [1] https://patchwork.kernel.org/patch/9109081
> >> [2]
> >> http://lists.infradead.org/pipermail/linux-mediatek/2016-May/005429.html
> >>

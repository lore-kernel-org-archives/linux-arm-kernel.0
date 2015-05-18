From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 18 May 2015 11:23:05 +0100
Subject: [RFC v2 PATCH 0/6] MT8173 IOMMU SUPPORT
In-Reply-To: <CAGS+omASN0GWiXYFg9kn7grWoKywqUiSwLZdW9BKc+S-Dnp+Cg@mail.gmail.com>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
 <CAGS+omASN0GWiXYFg9kn7grWoKywqUiSwLZdW9BKc+S-Dnp+Cg@mail.gmail.com>
Message-ID: <5559BD89.1060100@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/15 08:08, Daniel Kurtz wrote:
> On Fri, May 15, 2015 at 5:43 PM, Yong Wu <yong.wu@mediatek.com> wrote:
>>    This patch adds support for m4u(Multimedia Memory Management Unit),
>> Currently it only support the m4u with 2 levels of page table on mt8173.
>>
>>    It is based on Robin Murphy's arm64: IOMMU-backed DMA mapping[1].
>
>
> Hi Yong, Robin,

Hi Dan,

> The quoted "arm64 iommu-backed DMA mapping" patch set is from 2015-February.
> That was over 3 months ago.
> What is the status of this work?

Still in progress - I've been hampered a bit by having to rework a whole 
bunch of SMMU driver changes and other in-development stuff in parallel 
so I can do at least try to test as much as I can, not to mention 
various unrelated internal work. It also doesn't help that I also tried 
re-engineering things for v3 in a way that made some of it nicer, but 
turned out not to work so well elsewhere.

> Is that still the most recent version of these patches?
> If so, is there a plan when an update will be posted?
> Or, is there an updated public git repo with a more recent version of
> these patches?

This is now my primary focus again, so I'll get an updated posting out 
by the end of next week at the latest.

> My apologies if these questions have been asked and answered before
> and/or elsewhere.

Not on-list, at any rate, so there's no harm calling it out - helps me 
get my priorities straight ;)

Thanks,
Robin.

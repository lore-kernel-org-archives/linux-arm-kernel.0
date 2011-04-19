From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 19 Apr 2011 21:35:56 +0900
Subject: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
In-Reply-To: <201104191401.34818.arnd@arndb.de>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
	<201104181613.43572.arnd@arndb.de>
	<BANLkTi=dpqMFjW_B5-YsmoCJf62b8djj5g@mail.gmail.com>
	<201104191401.34818.arnd@arndb.de>
Message-ID: <BANLkTim_30SbVhPLFOaq-KYwz5N6NGCe6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 9:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 19 April 2011, Kyungmin Park wrote:
>> On Mon, Apr 18, 2011 at 11:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Monday 18 April 2011, Kyungmin Park wrote:
>> >> On Mon, Apr 18, 2011 at 8:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> >> >
>> >> > One missing piece is still a way for a platform to provide both
>> >> > the iommu and the dma-mapping API in a unified driver. Right now,
>> >> > you have to export both interface for a generic solution.
>> >>
>> >> Actually MSM and we (Michal, Marek) tried to merge the generic IOMMU
>> >> implementation into mm, but MM did't accept it.
>> >
>> > I'm confused. What do you mean with MM?
>> linux/mm, Memory Management.
>
> I'm still confused. What were you suggesting to merge in there?
> Do you have a link to a mailing list discussion?

First, Zach Pfeffer <zpfeffer@codeaurora.org> sent the patch
https://patchwork.kernel.org/patch/108736/

Second, Michal tried it.
http://lkml.org/lkml/2010/9/6/41

http://lwn.net/Articles/403643/
https://patchwork.kernel.org/patch/157451/

Thank you,
Kyungmin Park

>
> ? ? ? ?Arnd
>

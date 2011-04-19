From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Apr 2011 14:01:34 +0200
Subject: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
In-Reply-To: <BANLkTi=dpqMFjW_B5-YsmoCJf62b8djj5g@mail.gmail.com>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
	<201104181613.43572.arnd@arndb.de>
	<BANLkTi=dpqMFjW_B5-YsmoCJf62b8djj5g@mail.gmail.com>
Message-ID: <201104191401.34818.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 April 2011, Kyungmin Park wrote:
> On Mon, Apr 18, 2011 at 11:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 18 April 2011, Kyungmin Park wrote:
> >> On Mon, Apr 18, 2011 at 8:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> >
> >> > One missing piece is still a way for a platform to provide both
> >> > the iommu and the dma-mapping API in a unified driver. Right now,
> >> > you have to export both interface for a generic solution.
> >>
> >> Actually MSM and we (Michal, Marek) tried to merge the generic IOMMU
> >> implementation into mm, but MM did't accept it.
> >
> > I'm confused. What do you mean with MM?
> linux/mm, Memory Management.

I'm still confused. What were you suggesting to merge in there?
Do you have a link to a mailing list discussion?

	Arnd

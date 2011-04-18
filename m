From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2011 16:13:43 +0200
Subject: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
In-Reply-To: <BANLkTimc20N0nh9O0FaSXizW+bYOMx9Ddw@mail.gmail.com>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
	<201104181358.53521.arnd@arndb.de>
	<BANLkTimc20N0nh9O0FaSXizW+bYOMx9Ddw@mail.gmail.com>
Message-ID: <201104181613.43572.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 April 2011, Kyungmin Park wrote:
> On Mon, Apr 18, 2011 at 8:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > One missing piece is still a way for a platform to provide both
> > the iommu and the dma-mapping API in a unified driver. Right now,
> > you have to export both interface for a generic solution.
> 
> Actually MSM and we (Michal, Marek) tried to merge the generic IOMMU
> implementation into mm, but MM did't accept it.

I'm confused. What do you mean with MM?

> So now it's implemented at each SoCs. I think it's good chance to make
> a generic IOMMU feature for ARM consolidation.
>
> Before this idea, can you review our implementation at above URL?

I've commented on the main implementation for the IOMMU now.

	Arnd

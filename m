From: grgupta@ti.com (Gupta, Ramesh)
Date: Mon, 17 Sep 2012 23:16:13 +0530
Subject: [PATCH v6 0/2] ARM: New cache API for iommu
In-Reply-To: <CADysL2Y=aLJ8Eq5aJhB28VhwBvVY+4DyMFpu=MyOg6Sj+D+rYg@mail.gmail.com>
References: <CADysL2Y=aLJ8Eq5aJhB28VhwBvVY+4DyMFpu=MyOg6Sj+D+rYg@mail.gmail.com>
Message-ID: <CADysL2b7Tf7qbjZest7zUmESRXcq=BoxnD8yKAFR5O8rp=eyYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,


On Thu, Sep 13, 2012 at 12:39 PM, Gupta, Ramesh <grgupta@ti.com> wrote:
> From a00cbfadc0053a3c21812593997a1b7338234a9f Mon Sep 17 00:00:00 2001
> From: Ramesh Gupta G <grgupta@ti.com>
> Date: Thu, 13 Sep 2012 11:43:20 +0530
> Subject: [PATCH v6  0/2] ARM: New cache API for iommu
>
> This patch series is the next version to
> - add a new cache maintenance api to support non-coherent iommu drivers.
> - flush both L1 and L2 caches from OMAP iommu whenever the page table
>   memory is updated.
>
> Changes since the previous patch set (v5)
> - Fixed the RMK's comments on the flush function names in omap-iommu
> to reflect the
>   purpose.
>
> The implementation of the new api is based on
> the approach[1] discussed.
>
> [1]http://marc.info/?l=linux-kernel&m=131316512713815&w=2
>
> Ramesh Gupta G (2):
>   ARM: new cache maintenance api for iommu
>   OMAP:IOMMU:flush L1 and L2 caches

I have included your review comments in this series.
Could you please pull these patches if every thing looks fine?

thank you and regards
Ramesh Gupta G

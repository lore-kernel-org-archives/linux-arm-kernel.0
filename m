From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Jul 2011 00:00:56 -0700
Subject: [GIT PULL] omap iommu fixes for v3.0-rc
In-Reply-To: <BANLkTi=vd2TE6JjueGmY=ydRQRygo8-Q1Q@mail.gmail.com>
References: <BANLkTi=vd2TE6JjueGmY=ydRQRygo8-Q1Q@mail.gmail.com>
Message-ID: <20110701070056.GZ23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ohad Ben-Cohen <ohad@wizery.com> [110630 23:47]:
> Hi Tony,
> 
> Please pull from:
> 
> git://github.com/ohadbc/omap-iommu.git for-tony
> 
> To receive trivial iommu/iovmm fixes (iommu clk name fix, pte fix and
> a fix for iovmm's erroneous
> usage of sg_dma_len as reported by Russell).
> 
> All three patches were submitted to linux-omap and linux-arm-kernel for review,
> and are also attached below for convenience.

These look like real fixes, but can you please update the commits
with something like "This fixes an issue with foo when doing bar".

Otherwise it's easy to claim that these are "fixes for features that
never worked" and it might be hard to justify them this late into
the -rc cycle.

Tony

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 11 Mar 2014 12:15:00 +0000
Subject: Query on patch to be upstream ?
In-Reply-To: <CAD15agah=aWBHARXVNRgpxg1wepq+o=LML8bMms4ULpwuY_J0A@mail.gmail.com>
References: <CAD15agah=aWBHARXVNRgpxg1wepq+o=LML8bMms4ULpwuY_J0A@mail.gmail.com>
Message-ID: <20140311121500.GH31104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 08:46:24PM +0000, Ritesh Harjani wrote:
> Your Patch (arm64: Implement coherent DMA API based on swiotlb) from
> your devel branch going upstream (without modifications) ?

That's the plan. But once we get the system topology or Santosh's dma I
coherent DT bindings plan to make it DT-driven on whether a device is
coherent or not. For now we need some solution as I get people asking
about cache management for DMA buffers (though none of them got back
with a Tested-by ;)).

-- 
Catalin

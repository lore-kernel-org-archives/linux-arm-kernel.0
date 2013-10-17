From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 17 Oct 2013 07:05:23 +0200
Subject: change_page_attr() implementation for ARM?
Message-ID: <20131017.080523.1821831578701162178.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I found a bit old discussion[1] about CPA support on ARM32(Cortex-A9).

It seesm that CPA API on ARM wasn't possible because maintaining
multiple pagetables under SMP is difficult. Instead currently we are
using precallocated memory via DMA API.

Is this situation still same for Cortex-A15 and ARM64? If the
mismatched aliasing problem doesn't happen, is CPA API feasible?

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-October/069275.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-October/069315.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-October/069318.html

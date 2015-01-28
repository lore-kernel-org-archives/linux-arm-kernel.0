From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Jan 2015 13:46:39 +0000
Subject: [Patch v2 18/22] PCI: Use common resource list management code
 instead of private implementation
In-Reply-To: <1422442660-455-19-git-send-email-jiang.liu@linux.intel.com>
References: <1422442660-455-1-git-send-email-jiang.liu@linux.intel.com>
 <1422442660-455-19-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <20150128134639.GN1569@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 10:57:36AM +0000, Jiang Liu wrote:
> Use common resource list management data structure and interfaces
> instead of private implementation.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  arch/arm/kernel/bios32.c            |    5 ++---
>  arch/x86/pci/bus_numa.c             |    4 ++--
>  drivers/pci/bus.c                   |   18 ++++++------------
>  drivers/pci/host-bridge.c           |    8 ++++----
>  drivers/pci/host/pci-host-generic.c |    4 ++--
>  drivers/pci/host/pci-xgene.c        |    4 ++--
>  drivers/pci/host/pcie-xilinx.c      |    4 ++--
>  drivers/pci/probe.c                 |   10 +++++-----
>  include/linux/pci.h                 |    9 ++-------
>  9 files changed, 27 insertions(+), 39 deletions(-)

The arch/arm/ and drivers/pci/host/pci-host-generic.c bits look fine to
me:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will

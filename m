From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 4 Sep 2018 08:24:42 -0500
Subject: [PATCH 0/2] Drop node-local allocation during host controller
 initialisation
In-Reply-To: <20180828150513.32458-1-punit.agrawal@arm.com>
References: <20180828150513.32458-1-punit.agrawal@arm.com>
Message-ID: <20180904132442.GB107892@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 04:05:11PM +0100, Punit Agrawal wrote:
> Hi Bjorn,
> 
> As discussed before[0], here are a couple of patches to drop
> node-local allocations during host contoller initialisation. This set
> covers both arm64 and x86.
> 
> I'm posting early to give the patches time on the list as well in next
> in case there are issues we've missed.
> 
> The patches are based on v4.19-rc1 and has been boot tested on arm64
> and compile tested on x86.
> 
> Thanks,
> Punit
> 
> [0] https://www.spinics.net/lists/arm-kernel/msg669746.html
> 
> Punit Agrawal (2):
>   arm64: PCI: Remove node-local allocations when initialising host
>     controller
>   x86/PCI: Remove node-local allocation when initialising host
>     controller
> 
>  arch/arm64/kernel/pci.c | 5 ++---
>  arch/x86/pci/acpi.c     | 2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)

Applied with Will's ack on the arm64 patch to pci/enumeration for v4.20,
thanks!

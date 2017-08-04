From: tyreld@linux.vnet.ibm.com (Tyrel Datwyler)
Date: Fri, 4 Aug 2017 09:38:42 -0700
Subject: [PATCH] PCI: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-41-robh@kernel.org>
References: <20170718214339.7774-41-robh@kernel.org>
Message-ID: <dd5a317b-9e72-97bc-0386-8470998421c3@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2017 02:43 PM, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linux-pci at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-tegra at vger.kernel.org
> Cc: linuxppc-dev at lists.ozlabs.org
> ---
>  drivers/pci/host/pci-mvebu.c        | 8 ++++----
>  drivers/pci/host/pci-tegra.c        | 3 +--
>  drivers/pci/hotplug/pnv_php.c       | 4 ++--
>  drivers/pci/hotplug/rpadlpar_core.c | 4 ++--
>  drivers/pci/hotplug/rpaphp_core.c   | 2 +-
>  drivers/pci/hotplug/rpaphp_pci.c    | 4 ++--
>  drivers/pci/hotplug/rpaphp_slot.c   | 4 ++--
>  drivers/pci/pci-sysfs.c             | 4 ++--
>  drivers/pci/pci.c                   | 4 ++--
>  9 files changed, 18 insertions(+), 19 deletions(-)
> 

Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

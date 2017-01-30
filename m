From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 30 Jan 2017 15:59:47 +0100
Subject: [GIT PULL] iommu: KVM PCIe/MSI passthrough on ARM/ARM64 for 4.11
In-Reply-To: <20170127165021.GC10758@arm.com>
References: <20170127165021.GC10758@arm.com>
Message-ID: <20170130145946.GA28129@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 04:50:22PM +0000, Will Deacon wrote:
> Hi Joerg,
> 
> Please pull Eric's guest-MSI series for 4.11. This has been through
> considerable review and associated rework (including a session at LPC),
> but it has stabilised at last and we all seem to be happy with it. Eric's
> done a great job of respinning these and remaining patient while we
> pulled him in a bunch of different directions.
> 
> With these patches applied, it's possible for us to pass PCI devices
> through to KVM guests on arm64 using VFIO and have them signal interrupts
> using MSIs targetting the ITS via the SMMU. Acronym soup, sure, but it's
> much better than legacy wired irqs!
> 
> Cheers,
> 
> Will
> 
> --->8
> 
> The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:
> 
>   Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git iommu/guest-msi

Pulled, thanks Will.

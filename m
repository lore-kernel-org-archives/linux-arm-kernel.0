From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 9 Aug 2017 15:40:25 +0100
Subject: [GIT PULL] ARM64 ACPI IORT changes for v4.14
In-Reply-To: <20170809095729.GA12715@red-moon>
References: <20170809095729.GA12715@red-moon>
Message-ID: <20170809144024.xlflkeurm7k3rcy2@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 09, 2017 at 10:57:29AM +0100, Lorenzo Pieralisi wrote:
> please find below IORT changes aimed at the v4.14 release window:
> 
> - A patch from R.Murphy to improve current PCI aliases detection and
>   corresponding IOMMU streamid parsing/initialization
> - A patch from G.Kulkarni to add IOMMU IORT NUMA detection in the IORT
>   kernel layer following IORT specs update
> 
> These are not the only IORT patches for this merge window - other
> changes will go via IOMMU/ACPI trees and I expect no conflicts
> with them.
> 
> Please consider pulling, thanks,
> 
> Lorenzo
> 
> The following changes since commit aae4e7a8bc44722fe70d58920a36916b1043195e:
> 
>   Linux 4.13-rc4 (2017-08-06 18:44:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git tags/arm64-iort-for-v4.14
> 
> for you to fetch changes up to 5fe0ce3b9e514168427463d0c7a86dfa635da3d2:
> 
>   ACPI/IORT: numa: Add numa node mapping for smmuv3 devices (2017-08-08 16:44:38 +0100)

Pulled. Thanks.

-- 
Catalin

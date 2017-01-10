From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Jan 2017 14:17:07 +0000
Subject: [PATCH v7 12/19] iommu/arm-smmu-v3: Implement reserved region
 get/put callbacks
In-Reply-To: <1483969570-3154-13-git-send-email-eric.auger@redhat.com>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
 <1483969570-3154-13-git-send-email-eric.auger@redhat.com>
Message-ID: <20170110141706.GC27365@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 01:46:03PM +0000, Eric Auger wrote:
> iommu/arm-smmu: Implement reserved region get/put callbacks
> 
> The get() populates the list with the MSI IOVA reserved window.
> 
> At the moment an arbitray MSI IOVA window is set at 0x8000000
> of size 1MB. This will allow to report those info in iommu-group
> sysfs.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v4: creation
> ---
>  drivers/iommu/arm-smmu-v3.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Acked-by: Will Deacon <will.deacon@arm.com>

Will

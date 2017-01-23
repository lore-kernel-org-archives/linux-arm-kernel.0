From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Jan 2017 11:44:57 +0000
Subject: [PATCH v9 10/18] iommu/arm-smmu: Implement reserved region
 get/put callbacks
In-Reply-To: <1484859483-2866-11-git-send-email-eric.auger@redhat.com>
References: <1484859483-2866-1-git-send-email-eric.auger@redhat.com>
 <1484859483-2866-11-git-send-email-eric.auger@redhat.com>
Message-ID: <20170123114457.GG4622@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 08:57:55PM +0000, Eric Auger wrote:
> The get() populates the list with the MSI IOVA reserved window.
> 
> At the moment an arbitray MSI IOVA window is set at 0x8000000
> of size 1MB. This will allow to report those info in iommu-group
> sysfs.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>
> Tested-by: Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>
> Tested-by: Bharat Bhushan <bharat.bhushan@nxp.com>
> 
> ---

I acked this before:

Acked-by: Will Deacon <will.deacon@arm.com>

Will

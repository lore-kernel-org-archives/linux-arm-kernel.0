From: khandual@linux.vnet.ibm.com (Anshuman Khandual)
Date: Mon, 16 Apr 2018 15:13:04 +0530
Subject: [PATCH 04/12] iommu-helper: move the IOMMU_HELPER config symbol
 to lib/
In-Reply-To: <20180415145947.1248-5-hch@lst.de>
References: <20180415145947.1248-1-hch@lst.de>
 <20180415145947.1248-5-hch@lst.de>
Message-ID: <69224eb2-7056-4894-36d8-c6e9518df647@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2018 08:29 PM, Christoph Hellwig wrote:
> This way we have one central definition of it, and user can select it as
> needed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

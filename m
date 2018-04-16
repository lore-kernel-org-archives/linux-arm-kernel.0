From: khandual@linux.vnet.ibm.com (Anshuman Khandual)
Date: Mon, 16 Apr 2018 15:24:12 +0530
Subject: [PATCH 05/12] scatterlist: move the NEED_SG_DMA_LENGTH config
 symbol to lib/Kconfig
In-Reply-To: <20180415145947.1248-6-hch@lst.de>
References: <20180415145947.1248-1-hch@lst.de>
 <20180415145947.1248-6-hch@lst.de>
Message-ID: <5c1bd095-96f0-8038-4685-492761123be6@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2018 08:29 PM, Christoph Hellwig wrote:
> This way we have one central definition of it, and user can select it as
> needed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

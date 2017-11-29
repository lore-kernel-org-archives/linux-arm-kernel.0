From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 29 Nov 2017 09:38:51 -0800
Subject: [PATCH V2 5/7] PCI: add a return type for
 pci_reset_bridge_secondary_bus()
In-Reply-To: <1511763628-11856-6-git-send-email-okaya@codeaurora.org>
References: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
 <1511763628-11856-6-git-send-email-okaya@codeaurora.org>
Message-ID: <20171129173851.GF27742@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 01:20:26AM -0500, Sinan Kaya wrote:
> Getting ready to return an error from pci_reset_bridge_secondary_bus() when
> device is unreachable.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Looks ok, but I would just merge it into the next patch.

Reviewed-by: Christoph Hellwig <hch@lst.de>

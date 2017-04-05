From: hch@lst.de (Christoph Hellwig)
Date: Wed, 5 Apr 2017 08:27:40 +0200
Subject: [PATCH] net: thunderx: Switch to pci_alloc_irq_vectors
In-Reply-To: <1491298146-13609-1-git-send-email-tsrinivasulu@cavium.com>
References: <1491298146-13609-1-git-send-email-tsrinivasulu@cavium.com>
Message-ID: <20170405062740.GB26470@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 04, 2017 at 02:59:06PM +0530, dev.srinivasulu at gmail.com wrote:
> From: Thanneeru Srinivasulu <tsrinivasulu@cavium.com>
> 
> Remove deprecated pci_enable_msix API in favour of it's
> successor pci_alloc_irq_vectors.
> 
> Signed-off-by: Thanneeru Srinivasulu <tsrinivasulu@cavium.com>
> Signed-off-by: Sunil Goutham <sgoutham@cavium.com>

Looks good.

Are you fine with me queueing this up together with the other
pci_enable_msix() removal patches?

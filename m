From: hch@lst.de (Christoph Hellwig)
Date: Wed, 4 Oct 2017 08:30:28 +0200
Subject: [PATCH v2] nvme-pci: Use PCI bus address for data/queues in CMB
In-Reply-To: <20171002172128.GV8463@localhost.localdomain>
References: <1506763722-10687-1-git-send-email-abhishek.shah@broadcom.com>
 <20171001074203.GA11115@lst.de> <20171002172128.GV8463@localhost.localdomain>
Message-ID: <20171004063027.GA20459@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 02, 2017 at 11:21:29AM -0600, Keith Busch wrote:
> Yah, calling this a DMA address was a misnomer and confusing.

Abhishek, can you test if this works for you?

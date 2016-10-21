From: hch@lst.de (Christoph Hellwig)
Date: Fri, 21 Oct 2016 14:59:18 +0200
Subject: [PATCH] ahci: use pci_alloc_irq_vectors
In-Reply-To: <20161020154722.GH22012@rric.localdomain>
References: <1473088905-27670-1-git-send-email-hch@lst.de>
 <1473088905-27670-2-git-send-email-hch@lst.de>
 <20160906163946.GB24268@htj.duckdns.org>
 <20161020154722.GH22012@rric.localdomain>
Message-ID: <20161021125918.GA18082@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

can you try the latest fixed in the libata tree:

https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/log/?h=for-4.9-fixes

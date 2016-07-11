From: bharatku@xilinx.com (Bharat)
Date: Mon, 11 Jul 2016 05:55:09 +0000 (UTC)
Subject: PCIe MSI address is not written at
 =?utf-8?b?cGNpX2VuYWJsZV9tc2lfcmFuZ2U=?= call
Message-ID: <loom.20160711T075401-257@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

I have a query.
I see that when we use PCI_MSI_IRQ_DOMAIN to handle MSI's, MSI address is
not being written in to end point's PCI_MSI_ADDRESS_LO/HI at the call
pci_enable_msi_range.

Instead it is being written at the time end point requests irq.

Can any one tell the reason why is it handled in this manner ?

Correct me If my observation is wrong.

Thanks & Regards,
Bharat

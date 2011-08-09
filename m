From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 9 Aug 2011 11:23:20 +0200
Subject: How to handle named resources with DT?
Message-ID: <4E40FC88.5090403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

Trying to bind hwmod informations with DT, I'm facing a little limitation.
A bunch of drivers are using the platform_get_resource_byname, so the 
name for the resource is needed.

The name is used so far for IORESOURCE_MEM, IORESOURCE_IRQ and 
IORESOURCE_DMA types of resources.

Do you have any plan to add that, or do you have any clean way to avoid 
that without having to use the resource index?

Thanks,
Benoit

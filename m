From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Tue, 4 Nov 2014 11:00:31 -0600
Subject: [V10 PATCH 2/2] irqchip: gicv2m: Add supports for ARM GICv2m
 MSI(-X)
In-Reply-To: <5458CE31.3040404@linux.intel.com>
References: <1415052977-26036-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1415052977-26036-3-git-send-email-suravee.suthikulpanit@amd.com>
 <5458CE31.3040404@linux.intel.com>
Message-ID: <5459062F.6090603@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/4/14 07:01, Jiang Liu wrote:
> Hi Suravee,
> 	You may build a two level hierarchy irqdomains. Use the
> utilities in this thread
> http://www.spinics.net/lists/arm-kernel/msg374722.html to build an MSI
> irqdomain to manage MSI controllers
> in PCI devices. And build another irqdomain to manage SPI allocation
> in GICv2.
> 	That is: MSI irqdomain (program MSI registers)  -->
> GIV irqdomain (manage SPIs in GICv2 controller)

That's great. I'll look at this patch in and make use of it to create to 
MSI domain.

Thanks,

Suravee

> Regards!
> Gerry

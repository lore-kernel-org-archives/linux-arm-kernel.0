From: marex@denx.de (Marek Vasut)
Date: Wed, 27 Nov 2013 11:27:09 +0100
Subject: [PATCH 2/4] mtd: spi-nor: add a new data structrue spi_nor{}
In-Reply-To: <5295C85F.2030700@freescale.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <201311271032.13259.marex@denx.de> <5295C85F.2030700@freescale.com>
Message-ID: <201311271127.09823.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Huang Shijie,

> ? 2013?11?27? 17:32, Marek Vasut ??:
> > So this is your own device pointer or ... what kind of device pointer?
> 
> the pointer from spi_device{}

OK, I am 200% positive you need to add comments into the structure about what 
exactly does each member of it mean AND it would be nice if you could rename 
them to have less generic names (like spi_dev instead of dev).

Thanks ! :)

Best regards,
Marek Vasut

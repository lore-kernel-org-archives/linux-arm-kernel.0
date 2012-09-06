From: davem@davemloft.net (David Miller)
Date: Thu, 06 Sep 2012 16:46:07 -0400 (EDT)
Subject: [PATCH v2 2/6] net: pxaficp_ir: add irq resources
In-Reply-To: <1346960563-18689-3-git-send-email-robherring2@gmail.com>
References: <1346960563-18689-1-git-send-email-robherring2@gmail.com>
 <1346960563-18689-3-git-send-email-robherring2@gmail.com>
Message-ID: <20120906.164607.272336805646397930.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robherring2@gmail.com>
Date: Thu,  6 Sep 2012 14:42:39 -0500

> From: Rob Herring <rob.herring@calxeda.com>
> 
> In order to remove dependency on mach/irqs.h, add platform device
> resources for irqs.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Feel free to put this in via the ARM tree.

Acked-by: David S. Miller <davem@davemloft.net>

From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 1 Mar 2012 17:02:27 +0100
Subject: [PATCH] ARM: at91: Add support for configurable main clock
 frequency.
In-Reply-To: <4F4F925F.2020405@overkiz.com>
References: <4F4F925F.2020405@overkiz.com>
Message-ID: <20120301160227.GB31766@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:14 Thu 01 Mar     , Boris BREZILLON wrote:
> This patch provides main clock frequency configuration from device tree
> definition.
> 
> If the "main-clock" attribute of pmc node is not specified it takes
> 12MHz as default value.
> 
> With this patch we can add board support using a different main clock
> frequency (our custom board is using a 18,432MHz main clock).
> 
This is not the right way you need to define a fixed clock

and the pmc is at91rm9200 compatible

You did do the Documentation either

wait a few I'll send it's support

Best Regards,
J.

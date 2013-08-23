From: b32955@freescale.com (Huang Shijie)
Date: Fri, 23 Aug 2013 14:59:00 +0800
Subject: [PATCH V1 4/5] spi: Add Freescale QuadSpi driver
In-Reply-To: <20130822192158.GA10038@ld-irv-0074.broadcom.com>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>
 <1376885403-12156-5-git-send-email-b32955@freescale.com>
 <20130822192158.GA10038@ld-irv-0074.broadcom.com>
Message-ID: <52170834.1060003@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?08?23? 03:21, Brian Norris ??:
> Why does the size of the NOR flash need to be in the controller's device
> node? Shouldn't this be detected at run-time if possible? Or at least
> included as a property of m25p80, if absolutely required?
>
I suddenly realize that i need this property.

Since we may connect other devices, not NOR flash, to the Quadspi.

So this property shows us we connect a NOR to the Quadspi.



thanks
Huang Shijie

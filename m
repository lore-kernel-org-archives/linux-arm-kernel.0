From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 23 Nov 2012 12:04:13 +0000
Subject: [PATCH 11/16] ARM: picoxcell: use common irqchip_init
In-Reply-To: <1353448867-15008-12-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1353448867-15008-12-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121123120413.GB1941@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 11:01:02PM +0100, Thomas Petazzoni wrote:
> Now that we have a common irqchip infrastructure, use it on the
> picoxcell platform:
> 
>  * Use irqchip_init() as the ->irq_init() machine function. The
>    irqchip infrastructure already knows about the compatible strings
>    for the VIC IRQ controller driver.
> 
>  * No longer needed to set ->handle_irq() in the machine structure, as
>    it will be set by the VIC IRQ controller driver.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Jamie Iles <jamie@jamieiles.com>

Thanks,

Jamie

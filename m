From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Wed, 2 May 2018 10:03:38 +0200
Subject: [PATCH 08/17] irqchip/irq-mvebu-icu: disociate ICU and NSR
In-Reply-To: <20180421135537.24716-9-miquel.raynal@bootlin.com>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-9-miquel.raynal@bootlin.com>
Message-ID: <20180502100338.18817df0@windsurf.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, 21 Apr 2018 15:55:28 +0200, Miquel Raynal wrote:
> NSR (non-secure interrupts) are handled in the ICU driver like if there
> was only this type of interrupt in the ICU. Change this behavior to
> prepare the introduction of SEI (System Error Interrupts) support by
> moving the NSR code in a separate function. This is done under the form
> of a 'probe' function to ease future migration to NSR/SEI being platform
> devices part of the ICU.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

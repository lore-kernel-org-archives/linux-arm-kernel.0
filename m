From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Wed, 2 May 2018 10:02:17 +0200
Subject: [PATCH 07/17] irqchip/irq-mvebu-icu: make irq_domain local
In-Reply-To: <20180421135537.24716-8-miquel.raynal@bootlin.com>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-8-miquel.raynal@bootlin.com>
Message-ID: <20180502100217.432badb7@windsurf.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, 21 Apr 2018 15:55:27 +0200, Miquel Raynal wrote:
> Make the current MSI irq_domain local to ease the split between ICU
> platform device code and NSR platform device code.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

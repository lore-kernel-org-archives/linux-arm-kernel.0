From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Mon, 30 Apr 2018 15:51:38 +0200
Subject: [PATCH 05/17] irqchip/irq-mvebu-icu: clarify the reset
 operation of configured interrupts
In-Reply-To: <20180421135537.24716-6-miquel.raynal@bootlin.com>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-6-miquel.raynal@bootlin.com>
Message-ID: <20180430155138.6dad9bbb@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, 21 Apr 2018 15:55:25 +0200, Miquel Raynal wrote:
> Rewrite a small section to clarify the reset operation of interrupts
> already configured by ATF that we want to handle in the driver. This
> will simplify the introduction of System Error Interrupts support.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Looks good to me.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

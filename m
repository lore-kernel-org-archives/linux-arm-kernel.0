From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Nov 2011 13:01:35 +0000
Subject: -next fails to boot as of today on S3C6410
In-Reply-To: <20111123122855.GB7382@totoro>
References: <20111122192741.GG30583@opensource.wolfsonmicro.com>
 <20111122193124.GB9581@n2100.arm.linux.org.uk>
 <20111122193957.GH30583@opensource.wolfsonmicro.com>
 <20111122222135.GB7845@gallagher>
 <20111123120534.GO21073@opensource.wolfsonmicro.com>
 <20111123122855.GB7382@totoro>
Message-ID: <20111123130134.GB12227@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 12:28:55PM +0000, Jamie Iles wrote:

> Hmm, I really can't see what could cause this - we don't have a to_irq() 
> ops method, hwirq_base is correctly initialised to 0 with 32 irqs per 
> VIC and we aren't using dynamic irq_desc's.

Are you sure the numbers come out the same as they would otherwise.

> Do you have any low-level serial debug?

I tried adding some yesterday around the VIC registration in the CPU
code but it didn't actually appear on the console so I'm none the wiser.

From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 12 Apr 2017 09:15:28 +1000
Subject: [PATCH v3 21/32] powerpc: include default ioremap_nopost()
 implementation
In-Reply-To: <20170411142456.GB6821@red-moon>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <20170411122923.6285-22-lorenzo.pieralisi@arm.com>
 <1491917928.7236.8.camel@kernel.crashing.org>
 <20170411142456.GB6821@red-moon>
Message-ID: <1491952528.7236.26.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-04-11 at 15:24 +0100, Lorenzo Pieralisi wrote:
> Ok, point taken. BTW, may I ask you guys to have a look into this
> please ?
> 
> https://lkml.org/lkml/2017/4/6/743
> 
> It is a side effect of this thread (v2), not sure why <asm/io.h>
> on powerpc has to include <linux/io.h>.

Not sure how we ended up with that... it's odd indeed.

Michael ? Any reason we can't just remove it ?

Cheers,
Ben.

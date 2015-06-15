From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 15 Jun 2015 16:56:14 +0200
Subject: [PATCH] ARM: mm: enable L1 prefetch on Cortex-A9
In-Reply-To: <557EAC15.1070807@de.bosch.com>
References: <1434023550-20147-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <557EAC15.1070807@de.bosch.com>
Message-ID: <20150615165614.26b713b6@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Dirk Behme,

On Mon, 15 Jun 2015 12:42:29 +0200, Dirk Behme wrote:

> > This commit enables this L1 prefetch feature unconditionally on all
> > Cortex-A9 by setting bit 2 in the Auxiliary Control CP15
> > register. Note that since this bit only exists on Cortex-A9 but not on
> > Cortex-A5 or Cortex-R7, we separate the handling of Cortex-A9 from the
> > one of those two other cores.
> 
> Have you observed or measured any performance improvements or changes 
> using this change?

No, I haven't done any measurement myself, I merely wanted to propagate
some of the optimizations that were implemented in the Marvell BSP and
open the discussion around enabling the L1 prefetching feature of the
A9.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

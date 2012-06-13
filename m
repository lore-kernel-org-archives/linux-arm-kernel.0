From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 13 Jun 2012 07:37:56 +0000
Subject: [PATCH v5 10/14] ARM: OMAP2+: gpmc: waitpin helper
In-Reply-To: <4FD78748.2080504@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <bba49a35f81f33fbdfeda78a71cbe4aa3417d6a2.1339419492.git.afzal@ti.com>
 <4FD6783D.9030208@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997F7C@DBDE01.ent.ti.com>
 <4FD78748.2080504@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E998955@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Tue, Jun 12, 2012 at 23:45:36, Hunter, Jon wrote:

> GPMC_WAITPIN_IDX0 = 0
> GPMC_WAITPIN_0 = 1
> 
> So, GPMC_WAITPIN_IDX0 = GPMC_WAITPIN_0 - 1, assuming that you want idx =
> 0 and not 1. Or you could change you shift value too. I was just
> highlighting that they are not equal but one set of definitions could be
> used.

In that case we would be directly depending on user flag whose value may
or may not change and I don't think it is good to directly depend on it
for waitpin # calculation.

Regards
Afzal

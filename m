From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 11 Apr 2012 05:15:12 +0000
Subject: [PATCH v3 4/9] ARM: OMAP2+: gpmc-nand: populate gpmc configs
In-Reply-To: <4F84890A.30500@ti.com>
References: <cover.1333640054.git.afzal@ti.com>
 <6c120ab77d0900a6f977246bc58fb37c62280371.1333640054.git.afzal@ti.com>
 <4F84890A.30500@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9317C6F64@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Wed, Apr 11, 2012 at 00:54:58, Hunter, Jon wrote:
> > +#define	GPMC_NAND_CONFIG_NUM	4
> 
> Where does 4 come from?


It depends on the use case, for NAND, with the way it was being
configured (or number of times gpmc_cs_configure was being called)
4 are needed.

Regards
Afzal

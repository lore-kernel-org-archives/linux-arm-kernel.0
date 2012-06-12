From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 12 Jun 2012 08:41:50 +0000
Subject: [PATCH v5 08/14] ARM: OMAP2+: gpmc: bool type timing helper
In-Reply-To: <4FD670E1.5070807@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <36a87118922fb714e52d3d27235a35346aaf7b61.1339419492.git.afzal@ti.com>
 <4FD670E1.5070807@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E997F32@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Tue, Jun 12, 2012 at 03:57:45, Hunter, Jon wrote:

> > +	if (p->cycle2cyclesamecsen)
> > +		l |= GPMC_CONFIG6_CYCLE2CYCLESAMECSEN;
> > +	else
> > +		l &= ~GPMC_CONFIG6_CYCLE2CYCLESAMECSEN;
> > +	if (p->cycle2cyclediffcsen)
> > +		l |= GPMC_CONFIG6_CYCLE2CYCLEDIFFCSEN;
> > +	else
> > +		l &= ~GPMC_CONFIG6_CYCLE2CYCLEDIFFCSEN;
> > +	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG6, l);
> > +}
> 
> How about adding a sub-function like ...

Agree, that is better.

Regards
Afzal

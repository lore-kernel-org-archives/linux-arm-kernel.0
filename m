From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 13 Jun 2012 06:15:38 +0000
Subject: [PATCH v5 07/14] ARM: OMAP2+: gpmc: time setting (register#)
 helper
In-Reply-To: <4FD7909B.4040304@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <aafc6bc498e303be0bc86ce1ae395148fdca5c3d.1339419492.git.afzal@ti.com>
 <4FD7909B.4040304@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E998872@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Wed, Jun 13, 2012 at 00:25:23, Hunter, Jon wrote:

> When are the timings calculated? Why not just use the existing
> gpmc_cs_set_timings()?
> 
> I guess I am not convinced that we need to have multiple formats to pass
> timings such as clock, period, etc.
> 
> I think that it is sufficient to pass the timings as time (period) as is
> currently done and have the driver convert to clocks based upon the gpmc
> fclk rate.

Please see http://www.mail-archive.com/linux-omap at vger.kernel.org/msg69041.html

Regards
Afzal

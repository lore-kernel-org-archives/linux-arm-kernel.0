From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 13 Jun 2013 10:02:18 +0000
Subject: [PATCH v2 02/14] ARM: OMAP2+: AM43x: Kconfig
In-Reply-To: <20130613095454.GY8164@atomide.com>
References: <cover.1369658705.git.afzal@ti.com>
 <7642e0c701680ea94a8cc84059ff19e500813bf1.1369658705.git.afzal@ti.com>
 <20130612171200.GL8164@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EB1DEB2@DBDE04.ent.ti.com>
 <20130613095454.GY8164@atomide.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EB1E196@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Thu, Jun 13, 2013 at 15:24:54, Tony Lindgren wrote:
> * Mohammed, Afzal <afzal@ti.com> [130613 00:04]:

> > Patch 10 "ARM: OMAP2+: AM43x: basic dt support" is missing in
> > omap-for-v3.11/soc branch and omap soc pull request, can you
> > please help patch 10 also to go upstream.
> 
> Hmm if that's .dts changes, Benoit needs to queue that.

It is not dts change.

Patch 10 patches board-generic.c for DT boot (Benoit has already
picked up dts, that is patch 14).

Regards
Afzal

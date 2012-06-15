From: tony@atomide.com (Tony Lindgren)
Date: Fri, 15 Jun 2012 05:51:02 -0700
Subject: [PATCH v5 00/14] GPMC driver conversion
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E99A59D@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998065@DBDE01.ent.ti.com>
 <20120613123305.GS12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99A59D@DBDE01.ent.ti.com>
Message-ID: <20120615125102.GT12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mohammed, Afzal <afzal@ti.com> [120615 04:00]:
> 
> On Wed, Jun 13, 2012 at 18:03:05, Tony Lindgren wrote:
> > 
> > And we need the device tree bindings for GPMC so we can start dropping
> > board-*.c files as the GPMC seems to be last remaining blocker for
> > making rarely used legacy boards DT only. So it might be worth
> > playing with that so we don't again have to redo some parts.
> 
> We would prefer to do it one step at a time, have driver conversion changes
> first in, and then work on DT migration. Once these changes are in we have a
> base to work on for further DT migration.
> 
> Please let me know your opinion

Sounds good to me.

Tony

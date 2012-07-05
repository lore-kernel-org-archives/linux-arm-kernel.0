From: tony@atomide.com (Tony Lindgren)
Date: Thu, 5 Jul 2012 07:49:37 -0700
Subject: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9A36C6@DBDE01.ent.ti.com>
References: <20120628123207.GG19842@atomide.com> <4FEC89B9.3090404@ti.com>
 <20120702063651.GO4202@atomide.com> <4FF1D980.4040100@ti.com>
 <20120703081746.GJ1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A2BAC@DBDE01.ent.ti.com>
 <20120704075158.GQ1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A35E1@DBDE01.ent.ti.com>
 <20120705105535.GB1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A36C6@DBDE01.ent.ti.com>
Message-ID: <20120705144936.GF1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mohammed, Afzal <afzal@ti.com> [120705 05:03]:
> Hi Tony,
> 
> On Thu, Jul 05, 2012 at 16:25:35, Tony Lindgren wrote:
> > * Mohammed, Afzal <afzal@ti.com> [120705 03:29]:
> 
> > > Initially I thought you were suggesting that all peripheral drivers
> > > connected to gpmc should register their retime function (where
> 
> > Yes that's what I was suggesting.
> 
> To understand you better, peripheral drivers above refers to
> driver created out of present gpmc platform init code like
> gpmc-smsc911x.c. You were not referring to
> drivers/net/ethernet/smsc/smsc911x.c, right ?

Yes arch/arm/mach-omap2/gpmc-smsc911x.c for now, but eventually
that too should probably be just a regular driver. Just how it
will work together with drivers/net/ethernet/smsc/smsc911x.c is
still a bit open though :)

Tony

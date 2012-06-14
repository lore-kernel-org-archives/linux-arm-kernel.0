From: tony@atomide.com (Tony Lindgren)
Date: Wed, 13 Jun 2012 23:32:19 -0700
Subject: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E998F70@DBDE01.ent.ti.com>
References: <cover.1339419244.git.afzal@ti.com>
 <c4bd7d71e9950c09f9712077160b6231f566d8f3.1339419244.git.afzal@ti.com>
 <4FD63DBF.9000200@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997D9E@DBDE01.ent.ti.com>
 <4FD77E35.3050703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998767@DBDE01.ent.ti.com>
 <20120613113217.GK12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998D51@DBDE01.ent.ti.com>
 <20120613124215.GT12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998F70@DBDE01.ent.ti.com>
Message-ID: <20120614063218.GZ12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mohammed, Afzal <afzal@ti.com> [120613 07:09]:
> Hi Tony,
> 
> On Wed, Jun 13, 2012 at 18:12:15, Tony Lindgren wrote:
> 
> > > Or should additional timings be achieved without affecting old
> > > interface, but that it seems would necessitate more code
> > > duplication.
> > 
> > We should just keep the same timings as before, with values
> > added for the newly added registers.
> 
> What I understood from above is to get values bootloader used to
> set for those new timings & put in Kernel, right ?

Yeah and eventually to the .dts files.

Tony

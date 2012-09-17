From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Sep 2012 15:50:23 -0700
Subject: [PATCH v6 10/10] ARM: OMAP2+: tusb6010: generic timing calculation
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9E4DFE@DBDE01.ent.ti.com>
References: <bc000ac53bb1b3ae1a951bbcf372caf6336d2a19.1345524670.git.afzal@ti.com>
 <20120824194630.GU11011@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9BA589@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DC11D@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DEC85@DBDE01.ent.ti.com>
 <20120906204354.GJ1303@atomide.com>
 <20120911184606.GN23092@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9E253B@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9E3624@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9E4DFE@DBDE01.ent.ti.com>
Message-ID: <20120917225023.GJ11762@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mohammed, Afzal <afzal@ti.com> [120917 01:40]:
> Hi Tony,
> 
> On Fri, Sep 14, 2012 at 15:50:02, Mohammed, Afzal wrote:
> > * Mohammed, Afzal: Wednesday, September 12, 2012 3:20 PM
> 
> > > But some of the tusb async values is less by one. I need
> > > to get it right.
> > 
> > Reason has been identified. It was due to rounding error,
> > no changes are required in the expressions. Moving
> > completely to picoseconds resolves the issue.
> > 
> > Can you please try with the attached patch ?

Gave it a quick try and it seemed to work.. But when I tried
rebasing my patches for the cbus to keep things working with
the watchdog, I ran into multiple merge conflicts with
current linux next and gave up.
 
Care to repost this series updated against current linux
next?

I'm afraid I've pretty much lost track of all the patches
and rather not start resolving the conflicts as I'm sure
I'll break something else :)

Regards,

Tony

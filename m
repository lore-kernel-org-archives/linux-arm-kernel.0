From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 19 Sep 2012 13:43:05 +0000
Subject: [PATCH v6 10/10] ARM: OMAP2+: tusb6010: generic timing calculation
In-Reply-To: <20120917231001.GK11762@atomide.com>
References: <20120824194630.GU11011@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9BA589@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DC11D@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DEC85@DBDE01.ent.ti.com>
 <20120906204354.GJ1303@atomide.com> <20120911184606.GN23092@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9E253B@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9E3624@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9E4DFE@DBDE01.ent.ti.com>
 <20120917225023.GJ11762@atomide.com> <20120917231001.GK11762@atomide.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9E60D5@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Tue, Sep 18, 2012 at 04:40:02, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [120917 15:54]:

> > > > Can you please try with the attached patch ?
> > 
> > Gave it a quick try and it seemed to work.. But when I tried
> > rebasing my patches for the cbus to keep things working with
> > the watchdog, I ran into multiple merge conflicts with
> > current linux next and gave up.
> 
> OK went back to my original branch without current linux
> next and with the new cbus + retu driver from Aaro applied.
> Confirmed it's now working on n800 tusb6010.

Thanks for checking and confirming.

> > Care to repost this series updated against current linux
> > next?
> > 
> > I'm afraid I've pretty much lost track of all the patches
> > and rather not start resolving the conflicts as I'm sure
> > I'll break something else :)
> 
> You should still repost the whole updated series against
> linux next.

New updated version - v7, based over linux next has been posted.

Regards
Afzal

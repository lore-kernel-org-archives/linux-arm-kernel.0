From: tony@atomide.com (Tony Lindgren)
Date: Mon, 4 Mar 2013 13:23:57 -0800
Subject: [PATCH] ARM: OMAP1: Fix build related to kgdb.h no longer
 including serial_8250.h
In-Reply-To: <201303042032.50856.arnd@arndb.de>
References: <20130211224600.GB4801@atomide.com>
 <20130304190238.GU11806@atomide.com>
 <201303042032.50856.arnd@arndb.de>
Message-ID: <20130304212357.GY11806@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [130304 12:36]:
> On Monday 04 March 2013, Tony Lindgren wrote:
> > > Arnd & Olof, can you please apply this to your non-critical fixes
> > > or some other branch that gets merged early on during the merge
> > > window?
> > 
> > I'll apply this into omap-for-v3.9-rc1/fixes.
> > 
> 
> I totally missed this one from you, and I have a couple more such
> fixes for OMAP1 (and others) that I'll try to send out ASAP.

No problem. I have this and few other omap fixes queued up in
omap-for-v3.9-rc1/fixes. Will send a pull req on Tuesday for that.

Regards,

Tony

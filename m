From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 4 Mar 2013 20:32:50 +0000
Subject: [PATCH] ARM: OMAP1: Fix build related to kgdb.h no longer
 including serial_8250.h
In-Reply-To: <20130304190238.GU11806@atomide.com>
References: <20130211224600.GB4801@atomide.com>
 <20130304190238.GU11806@atomide.com>
Message-ID: <201303042032.50856.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 March 2013, Tony Lindgren wrote:
> > Arnd & Olof, can you please apply this to your non-critical fixes
> > or some other branch that gets merged early on during the merge
> > window?
> 
> I'll apply this into omap-for-v3.9-rc1/fixes.
> 

I totally missed this one from you, and I have a couple more such
fixes for OMAP1 (and others) that I'll try to send out ASAP.

	Arnd

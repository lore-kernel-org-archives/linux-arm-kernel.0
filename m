From: tony@atomide.com (Tony Lindgren)
Date: Mon, 3 Oct 2011 11:26:49 -0700
Subject: [PATCH 26/30] ARM: omap: add board autoselection
In-Reply-To: <5055144.Y0IUdMEWXQ@wuerfel>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<3656685.pM1zNST8gQ@wuerfel> <4E898010.80208@ti.com>
	<5055144.Y0IUdMEWXQ@wuerfel>
Message-ID: <20111003182649.GC6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [111003 02:20]:
> On Monday 03 October 2011 11:27:44 Cousson, Benoit wrote:
> > >
> > > In the long run, I'd hope we can just get rid of these for subarchitectures
> > > that support device tree probing and make the device tree based machine
> > > description unconditional.
> > 
> > This is really our goal, we will have soon the board-generic.c for that, 
> > someone will just have to migrate these ~30 board files to device tree 
> > DTS files 
> 
> For the purpose of build-time validation using randconfig, there is no
> problem in keeping some board files forever, as long as the generic board
> file is always built-in.

Yes please leave out the list so we don't need to constantly update it.
Let's just always build in MACH_OMAP_GENERIC.

Regards,

Tony

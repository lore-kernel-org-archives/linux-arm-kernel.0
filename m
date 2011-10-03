From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Oct 2011 11:54:41 +0200
Subject: [PATCH 26/30] ARM: omap: add board autoselection
In-Reply-To: <4E898010.80208@ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<3656685.pM1zNST8gQ@wuerfel> <4E898010.80208@ti.com>
Message-ID: <5055144.Y0IUdMEWXQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 October 2011 11:27:44 Cousson, Benoit wrote:
> >
> > In the long run, I'd hope we can just get rid of these for subarchitectures
> > that support device tree probing and make the device tree based machine
> > description unconditional.
> 
> This is really our goal, we will have soon the board-generic.c for that, 
> someone will just have to migrate these ~30 board files to device tree 
> DTS files 

For the purpose of build-time validation using randconfig, there is no
problem in keeping some board files forever, as long as the generic board
file is always built-in.

	Arnd

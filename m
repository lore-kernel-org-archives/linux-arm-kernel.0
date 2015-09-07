From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 07 Sep 2015 17:45:08 +0200
Subject: [PATCH] ARM: fix bug which lowmem size is limited to 760MB
In-Reply-To: <alpine.LFD.2.20.1509071128151.22877@knanqh.ubzr>
References: <20150903091044.GW21084@n2100.arm.linux.org.uk>
 <1713935.2YV1sNJUyb@wuerfel>
 <alpine.LFD.2.20.1509071128151.22877@knanqh.ubzr>
Message-ID: <6035791.Tn8TYmTeXT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 September 2015 11:34:36 Nicolas Pitre wrote:
> 
> That shifts the risk to user space though.  But if there is a regression 
> there, it will manifest itself on all systems and not only with some 
> particular hardware.

I'd consider that a good thing, as it makes it easier to test when
you see the same behavior on systems with any memory size.

	Arnd

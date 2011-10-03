From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Oct 2011 11:51:10 +0200
Subject: [PATCH 02/30] video/omap: fix dependencies
In-Reply-To: <1317624830.2026.6.camel@deskari>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-3-git-send-email-arnd@arndb.de>
	<1317624830.2026.6.camel@deskari>
Message-ID: <4098767.aLCa4gBHda@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 October 2011 09:53:50 Tomi Valkeinen wrote:
> Your patch will conflict with both of those changes. Is it ok for you to
> drop this patch, and I'll make a new one on top of my changes to clean
> up the Makefile in a similar way than you did? The new patch wouldn't
> make it in the next merge window, though, but I don't think this patch
> is fixing any bigger bug, so perhaps it's not so urgent.

Sure, no problem. I'll put it into my "hacks" branch then, so I can
still do randconfig builds and we get back to it later.

	Arnd

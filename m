From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 30 Aug 2012 20:59:18 +0200
Subject: [PATCH] ARM: Kirkwood: Fix 'SZ_1M' undeclared here for
 db88f6281-bp-setup.c
In-Reply-To: <20120830185050.GZ19437@titan.lakedaemon.net>
References: <1346305152-14618-1-git-send-email-andrew@lunn.ch>
 <20120830171236.GS19437@titan.lakedaemon.net>
 <20120830180853.GP9886@lunn.ch>
 <20120830185050.GZ19437@titan.lakedaemon.net>
Message-ID: <20120830185918.GR9886@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Stable does not need it. As i said, it only broke 23 August with
> > linux-next. So this is needed for only 3.7.
> 
> Do we know caused the break?  Is it a fix destined for -stable?

I've not bisected it.

     Andrew

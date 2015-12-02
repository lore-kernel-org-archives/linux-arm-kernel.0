From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 3 Dec 2015 00:59:48 +0100
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <10084728.p75H39SaXO@wuerfel>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <20151202202240.GH8644@n2100.arm.linux.org.uk>
 <20151202203810.GH9866@lunn.ch> <10084728.p75H39SaXO@wuerfel>
Message-ID: <20151202235948.GA1751@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I agree. We have multiplatform dove already, it is in mach-mvebu. Do
> > we really need both mach-dove and mach-mvebu dove in one kernel?
> 
> I'm also fine with deleting mach-dove.

Ah, maybe i worded that badly. By "in one kernel" i mean kernel
binary. We should keep mach-dove, and allow a mach-dove build of the
kernel. But there is no reason for that build to be multi-platform. We
already have multi-platform dove via mvebu.

Anyway, i see your v2 patches do leave mach-dove as a single platform
kernel.

	Andrew

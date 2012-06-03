From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 3 Jun 2012 21:09:48 +0200
Subject: Kernel 3.4 on Dreamplug: no serial console
In-Reply-To: <20120603184049.GF14756@titan.lakedaemon.net>
References: <loom.20120602T135715-548@post.gmane.org>
 <loom.20120603T172511-816@post.gmane.org>
 <1475115.7BtuQWbDGm@gromit> <201206031712.18645.arnd@arndb.de>
 <20120603184049.GF14756@titan.lakedaemon.net>
Message-ID: <20120603190948.GA2059@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The problem involves CONFIG_ARM_PATCH_PHYS_VIRT and causes the system
> not to boot.  I'm not sure if this is dreamplug specific, kirkwood, or
> all orion.  I've only heard reports regarding dreamplug, but that
> doesn't mean it's limited to that board.

It seems to be kirkwood. Orion5x does not have the problem.

   Andrew

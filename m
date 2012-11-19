From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Nov 2012 07:11:15 +0100
Subject: [PATCH] Dove: Fix irq_to_pmu()
In-Reply-To: <20121118223125.GZ3290@n2100.arm.linux.org.uk>
References: <20121118162944.GV3290@n2100.arm.linux.org.uk>
 <20121118163932.GW3290@n2100.arm.linux.org.uk>
 <50A9304C.9010006@mvista.com>
 <20121118203815.GY3290@n2100.arm.linux.org.uk>
 <20121118210229.GV22106@titan.lakedaemon.net>
 <20121118223125.GZ3290@n2100.arm.linux.org.uk>
Message-ID: <20121119061115.GJ14643@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2012 at 10:31:25PM +0000, Russell King - ARM Linux wrote:

> Now I'm getting to the point of wondering how well tested any of this
> dove/kirkwood/orion code actually is... it all looks rather insanely
> fragile to me tonight.

Hi Russell

I would say, anything a NAS box typically uses, is well tested. When
you get away from that use case, expect problems.

    Andrew

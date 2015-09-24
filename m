From: davem@davemloft.net (David Miller)
Date: Thu, 24 Sep 2015 15:15:54 -0700 (PDT)
Subject: [PATCH v3 0/9] Phy, mdiobus, and netdev struct device fixes
In-Reply-To: <20150924215731.GE20825@lunn.ch>
References: <20150924191754.GC21513@n2100.arm.linux.org.uk>
 <20150924215731.GE20825@lunn.ch>
Message-ID: <20150924.151554.619662567057050978.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 24 Sep 2015 23:57:31 +0200

> I built the FEC driver as a module, and it won't unload:
> 
>  kernel:unregister_netdevice: waiting for eth1 to become free. Usage count = 1
> unregister_netdevice: waiting for eth1 to become free. Usage count = 1
> 
> i assume because DSA holds a reference. I've not tried a fully module
> build, DSA has issues with that.
> 
> Tested-by: Andrew Lunn <andrew@lunn.ch>

So, is this a regression?

Please don't provide a "Tested-by: " tag is you encounter a new
problem which could have been introduced by the changes in question.
That _REALLY_ screws everything up for me.

Thank.

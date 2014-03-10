From: davem@davemloft.net (David Miller)
Date: Sun, 09 Mar 2014 20:41:01 -0400 (EDT)
Subject: [PATCH] net: phy: Add sysfs attribute to prevent PHY suspend
In-Reply-To: <531D094C.1090205@gmail.com>
References: <531CF864.9040406@gmail.com>
 <20140309.203001.1318893833441564547.davem@davemloft.net>
 <531D094C.1090205@gmail.com>
Message-ID: <20140309.204101.47552917508273123.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date: Mon, 10 Mar 2014 01:37:32 +0100

> The mechanism is manual, no automatic way to determine it.

We recognize BIOS and ACPI bugs and work around them, by looking at
version information and whatnot, so you really can't convince me that
something similar can't be done here perhaps in the platform code.

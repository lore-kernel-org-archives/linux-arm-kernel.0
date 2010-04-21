From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Apr 2010 09:37:02 +0100
Subject: [RFC/PATCH] dns323: Support for HW rev C1
In-Reply-To: <1271838700.2330.143.camel@pasglop>
References: <1271838486.2330.139.camel@pasglop>
	<1271838700.2330.143.camel@pasglop>
Message-ID: <20100421083702.GA11425@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 06:31:40PM +1000, Benjamin Herrenschmidt wrote:
> Do you have a hook in ARM for adding something to /proc/cpuinfo where I
> could export the board revision ? Or a "standard" practice to do that ?

That's the purpose of system_rev, originally provided for Netwinders to
identify revision 3, 4, or 5 of the Netwinder hardware.

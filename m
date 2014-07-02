From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 2 Jul 2014 11:03:31 -0400
Subject: [PATCH 1/2] ARM: kirkwood: add appended DTB support in
 kirkwood_defconfig
In-Reply-To: <20140702144340.GJ20799@lunn.ch>
References: <1404305778-17757-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140702134655.GE20799@lunn.ch>
 <20140702142510.GM23978@titan.lakedaemon.net>
 <20140702143157.GH20799@lunn.ch>
 <20140702143950.GN23978@titan.lakedaemon.net>
 <20140702144340.GJ20799@lunn.ch>
Message-ID: <20140702150331.GO23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 04:43:40PM +0200, Andrew Lunn wrote:
> > Ok, just make kirkwood_defconfig removal a separate patch so we can
> > revert it later if we want.
> 
> Hi Jason
> 
> How would that work exactly, without having mach-kirkwood?

Set ARCH_MVEBU, MACH_KIRKWOOD, unset ARCH_MULTI_V5 and adjust the
Kconfig to allow such a scenario.

It may not be desirable right now, but having it as a separate patch
doesn't hurt anything, and it keeps the door open to the possibility in
the future.

thx,

Jason.

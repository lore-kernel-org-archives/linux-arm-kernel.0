From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 26 Oct 2012 14:48:04 +0200
Subject: [PATCH V2 0/4] Adding SATA support for Armada 370/XP
In-Reply-To: <20121026123908.GH21046@lunn.ch>
References: <1351254650-26861-1-git-send-email-gregory.clement@free-electrons.com>
 <20121026123908.GH21046@lunn.ch>
Message-ID: <20121026144804.640eabaf@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Fri, 26 Oct 2012 14:39:08 +0200, Andrew Lunn wrote:

> What about the openblocks-ax3?

Gr?gory does not (yet) have an OpenBlocks AX3, but I'm planning to do
the work for SATA soon for this platform. However, supporting the
OpenBlocks AX3 is not part of our official contract with Marvell, it's
just an additional thing I'm happily doing on my spare time. So I'll
provide support for SATA, network and SMP on OpenBlocks AX3, but we
would like to first see the SATA support for the Marvell evaluation
boards being merged, and on my side the basic support for the
OpenBlocks AX3. I'll send followup patches to enable SATA/network/SMP
on OpenBlocks AX3 later on, if that's ok for you?

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

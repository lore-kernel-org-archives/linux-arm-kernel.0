From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 12 Nov 2012 18:30:07 +0100
Subject: [4/4] arm: mvebu: enable Ethernet controllers on Armada 370/XP
 eval boards
In-Reply-To: <20121104020311.GA26747@obsidianresearch.com>
References: <1351245804-31478-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121104020311.GA26747@obsidianresearch.com>
Message-ID: <20121112183007.281970f5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Sat, 3 Nov 2012 20:03:11 -0600, Jason Gunthorpe wrote:

> We've been using the patches from Ian Molton for the mv643xx driver
> that make it use the more standard, separately described MDIO
> bus..
> 
> Please consider not copying the unsual 'phy-addr' binding
> for the new driver.

I have just sent a fifth version of the patch set that implements a
separate DT node for the PHY devices, as well as a separate MDIO bus.

Please let me know if it solves your comment.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

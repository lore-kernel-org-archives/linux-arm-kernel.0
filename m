From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 4 Nov 2012 10:12:12 +0100
Subject: [4/4] arm: mvebu: enable Ethernet controllers on Armada 370/XP
 eval boards
In-Reply-To: <20121104020311.GA26747@obsidianresearch.com>
References: <1351245804-31478-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121104020311.GA26747@obsidianresearch.com>
Message-ID: <20121104101212.33449081@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jason,

On Sat, 3 Nov 2012 20:03:11 -0600, Jason Gunthorpe wrote:

> We've been using the patches from Ian Molton for the mv643xx driver
> that make it use the more standard, separately described MDIO
> bus..

[...]

> Where the MDIO bus is explicit, the PHY, its address and parameters
> are explicit - the PHY has an of_node pointer - and phy-handle is used
> to connect them.
> 
> I'm not sure having the MDIO bus as a distinct top level item is
> great, considering how the registers overlap.. It might be better
> to put it under the egiga0 block? But that is a minor nit :)

Thanks for your comment. I'll see what I can come up with to make the
phy a separate DT entity.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Feb 2016 16:25:57 +0100
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for
 v4.6
In-Reply-To: <cover.1456443769.git.horms+renesas@verge.net.au>
References: <cover.1456443769.git.horms+renesas@verge.net.au>
Message-ID: <3261857.3dzYkr9LzW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 February 2016 08:53:07 Simon Horman wrote:
> Second Round of Renesas ARM Based SoC DT Updates for v4.6
> 
> * Add L2 cache-controller nodes to r8a779[0134] and r8a73a4
> * Add etheravb support to r8a7794
> * Correct JP3 jumper description on Porter
> * Enable thermal zone on  r8a779[013]
> * Replace gpio-key, wakeup with wakeup-source property on r8a7794
> * Use demuxer for IIC0/I2C0 on lager
> * Use fallback etheravb, pci and pcie compatibility strings as appropriate
> 
> 

Merged into next/dt, thanks!

	Arnd

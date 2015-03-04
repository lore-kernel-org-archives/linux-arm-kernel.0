From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Mar 2015 23:00:09 +0100
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.1
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
Message-ID: <2150089.GpZcSdVLjm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 February 2015 15:21:25 Simon Horman wrote:
> Renesas ARM Based SoC DT Updates for v4.1
> 
> * Increase hardware coverage of DT for various SoCs
> * Add PFC information for emev2 SoC
> * Remap entire APMU region for r8a7791 and r8a7790 SoCs
> * Declare the full 512 MiB of RAM for kzm9g board
> * Add selectable sources to DIV6 clocks to sh73a0 SoC
> * Add missing INTCA0 clock for irqpin module on sh73a0 SoC
> * Set control-parent for all irqpin node on sh73a0 SoC
> 

Pulled into next/dt, thanks!

	Arnd

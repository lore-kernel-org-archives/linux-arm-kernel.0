From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Apr 2016 23:02:28 +0200
Subject: [GIT PULL v2] Renesas ARM Based SoC DT Updates for v4.7
In-Reply-To: <cover.1461558315.git.horms+renesas@verge.net.au>
References: <cover.1461558315.git.horms+renesas@verge.net.au>
Message-ID: <4737327.YB9LJZXs32@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 April 2016 14:27:31 Simon Horman wrote:
> Renesas ARM Based SoC DT Updates for v4.7
> 
> * Configure NMI key as wakeup source in DT of kzm9g board
> * Add SDHI support to DT of gose board
> * Add support of UHS-I SDR-50 for SDHI to DT of r8a7790 SoC
> * Correct interrupt type for ARM TWD in DT of r8a7779 and sh73a0 SoCs
> * Add IIC support to DT of r8a7794 SoC
> * Add CAN support to DT of r8a7793 and r8a7794 SoCs
> * Add SCIF2 support to r8a7790 device tree
> * Use CAN, JPU and USB3.0 fallback compatibility string
>   in DT of r8a7791 and r8a7790 SoCs
> 

Pulled into next/dt, thanks!

	Arnd

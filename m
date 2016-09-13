From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Sep 2016 17:35:25 +0200
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for
 v4.9
In-Reply-To: <cover.1473234371.git.horms+renesas@verge.net.au>
References: <cover.1473234371.git.horms+renesas@verge.net.au>
Message-ID: <14474684.Hhngk1emgJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 7, 2016 9:49:30 AM CEST Simon Horman wrote:
> Second Round of Renesas ARM Based SoC DT Updates for v4.9
> 
> Fixes (for v4.9):
> * Correct PWM clock parent on r8a7794 SoC
> 
> Clean-up:
> * Remove obsolete vsp1 properties from r8a779[01] SoCs
> 
> New boards:
> * Add r8a7792/wheat and r7s72100/rskrza1 boards
> 
> Enablement:
> * Enable LEDs, DU, SDHI on r8a7792/blanche board
> * Enable MMCIF and SDHI on r8a7794/alt board
> * Add SPI and VSP1 to r8a7792 SoC
> * Add ethernet to r7s72100 SoC
> 

Pulled into next/dt, thanks!

	Arnd

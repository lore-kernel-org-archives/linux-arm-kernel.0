From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Nov 2016 16:45:24 +0100
Subject: [GIT PULL v2] Second Round of Renesas ARM Based SoC DT Updates
 for v4.10
In-Reply-To: <cover.1479931686.git.horms+renesas@verge.net.au>
References: <cover.1479931686.git.horms+renesas@verge.net.au>
Message-ID: <6048589.rSbvWcLf7m@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 23, 2016 9:14:33 PM CET Simon Horman wrote:
> Second Round of Renesas ARM Based SoC DT Updates for v4.10
> 
> Enhancements:
> * Add device nodes for PRR
> * Add r8a7745 SoC and sk-rzg1e board
> * Add r8a7743 SoC and sk-rzg1m board
> * Enable SDR-104 and I2C demuxer on alt, koelsch and lager boards
> 
> Corrections:
> * Use SYSC "always-on" PM Domain for sound on r8a7794 SoC
> * Correct hsusb parent clock on r8a7794 SoC
> * Correct PFC names for DU on alt board
> 

Pulled into next/dt, thanks!

	Arnd

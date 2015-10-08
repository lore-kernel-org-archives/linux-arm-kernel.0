From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Oct 2015 17:21:05 +0200
Subject: [GIT PULL v2] Renesas ARM Based SoC DT Updates for v4.4
In-Reply-To: <cover.1444182812.git.horms+renesas@verge.net.au>
References: <cover.1444182812.git.horms+renesas@verge.net.au>
Message-ID: <6703006.5arY5jeCbV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 October 2015 10:58:00 Simon Horman wrote:
> The main differences since v1 of this pull-request are:
> 
> * Removed "Add missing CPG/MSTP Clock Domain for sound "* patches
>   which are fixes now present in the ARM SoC fixes branch
>   via the renesas-fixes-for-v4.3 tag of the renesas tree.
> * Enable more hardware via DT
>   + Enable PCI, USB PHY and HS, and VIN support on r8a7794/Silk
>   + Add initial support for r8a7791/porter
>   + Add common file for AA121TD01 panel
> 
> 

Merged into next/dt, thanks!

	Arnd

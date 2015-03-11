From: horms@verge.net.au (Simon Horman)
Date: Wed, 11 Mar 2015 09:55:25 +0900
Subject: [PATCH 0/4] ARM: shmobile: koelsch / lager regulator updates
In-Reply-To: <1425931617-5479-1-git-send-email-geert+renesas@glider.be>
References: <1425931617-5479-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150311005524.GC11701@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 09, 2015 at 09:06:53PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series contains two DTS updates each for r8a7791/koelsch and
> r8a7790/lager:
>   - add the missing interrupt for the da9210 regulators,
>   - add device nodes for the da9063 pmics.
> 
> The da9063 pmic allows the system to be restarted when the watchdog
> timer times out ("cat > dev/watchdog0", and wait 8 s), or when a system
> restart is requested ("reboot").
> 
> This series depends on "[PATCH] ARM: shmobile: R-Car Gen2: Add
> da9063/da9210 regulator quirk".
> 
> An earlier version of patch [2/4] has been posted before as "[PATCH 3/4]
> ARM: shmobile: koelsch: Add DA9063 PMIC device node for system
> restart", but it caused havoc without the quirk.
> 
> This has been tested on r8a7791/koelsch.

Thanks, I have queued this up for v4.1 on top of the above mentioned patch.

From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Dec 2015 10:16:24 -0800
Subject: [PATCH 0/2] ARM: dts: Use MMC pwrseq instead regulators for IGEP
 WiFi init
In-Reply-To: <1449165729-993-1-git-send-email-javier@osg.samsung.com>
References: <1449165729-993-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20151203181624.GW23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier@osg.samsung.com> [151203 10:03]:
> Hello,
> 
> This series converts the IGEPv2 (IGEP0020) and IGEP COM Module (IGEP0030)
> Device Tree to use the MMC power sequence provider to initialize the SDIO
> WiFi chip instead of using fake fixed regulators to just toggle the Reset
> and Power pins in the chip.
> 
> The patches were tested on an DM3730 IGEPv2 board but the IGEP COM Module
> is the same with regard to the SDIO WiFi so it should be safe to land too.
> 
> The IGEPv2 Rev.F and the IGEP COM Module Rev.G DTS were not converted due
> using a different WiFi chip (wlcore instead of libertas) than the one in
> the board I've access to test so I preferred to leave those untouched.

Do you have some solution for the start-up latency issue?

Regards,

Tony

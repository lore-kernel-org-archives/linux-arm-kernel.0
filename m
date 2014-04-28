From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Apr 2014 10:42:35 -0600
Subject: [PATCH 00/38] MMC updates, plus CuBox-i WiFi support
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Message-ID: <535E84FB.4080305@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2014 12:55 PM, Russell King - ARM Linux wrote:
> All,
> 
> This is where I'm at with trying to clean up the SDHCI mess, and sort out
> issues I've noticed when trying to get UHS support working on CuBoxes.
> This is my full patch set, but I recommend not applying patch 37 as there
> appears to be a hardware issue preventing it working reliably.
> 
> In any case, patches 0-33 inclusive are the SDHCI clean up, based against
> v3.15-rc1.  Patches 34 and 35 are Olof's Wifi support, 36 is my fix against
> those, and 38 adds the Broadcom Wifi and BT support for CuBox.
> 
> The questions over how to handle these devices were never properly settled,
> so I recommend against merging patch 34 onwards.  As for the rest, I'm not
> planning on any further work, so it may be a good idea for people to
> consider testing them with a view to getting them merged.

The series,
Tested-by: Stephen Warren <swarren@nvidia.com>

(On an NVIDIA Tegra "Jetson TK1" board, with the patches applied on top
of next-20140428, also with Andrew Bresticker's Tegra SDHCI patches
"mmc: tegra: disable UHS modes" and "mmc: tegra: fix reporting of base
clock frequency" applied)

From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 08 Jan 2013 21:38:27 +0100
Subject: [PATCH v2] Device Tree binding for the mvsdio driver and related
 changes
In-Reply-To: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1550811.iJ6ejRLQ3V@bender>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas,

On Friday 21 December 2012 15:48:59 Thomas Petazzoni wrote:
> Hello,
> 
> This series of patches adds a Device Tree binding to the mvsdio driver
> (the driver for the SDIO interface found in many Marvell SoCs), and
> uses this binding to enable the SDIO interface on Armada 370 and
> Armada XP platforms, as well as converting the Kirkwood platforms to
> using the Device Tree to probe the SDIO interface.
> 
> The series has been tested on Kirkwood Topkick, Armada 370 Mirabox,
> Armada XP OpenBlocks, Armada 370 DB and Armada XP DB. The changes on
> the Dreamplug and MPLCEC4 boards should be tested by their respective
> maintainers if possible.

Tested on DB-MV784MP-GP and RD-A370-A1 successfully with a 16GB card. Thanks!

Tested-by: Florian Fainelli <florian@openwrt.org>
-- 
Florian

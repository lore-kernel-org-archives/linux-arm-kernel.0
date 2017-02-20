From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Feb 2017 17:07:39 +0000
Subject: [PATCH v6 00/14] mmc: Add support to Marvell Xenon SD Host
 Controller
In-Reply-To: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
Message-ID: <20170220170739.GL21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 06:01:40PM +0100, Gregory CLEMENT wrote:
> Hello,
> 
> This the sixth version of the series adding support for the SDHCI
> Xenon controller. It can be currently found on the Armada 37xx and the
> Armada 7K/8K but will be also used in more Marvell SoC (and not only
> the mvebu ones actually).
> 
> Most of the following changes had been discussed on the mailing list,
> except the new compatible string.
> 
> It occurred that the xenon controller was integrated in a different
> way in the AP806 and the CP110 which both are part of the Armada 7K/8K
> SoCs. For example the Xenon controller in CP110 doesn't not support
> HS200.

Seems to continnue to work on the Macchiatobin board.

Tested-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

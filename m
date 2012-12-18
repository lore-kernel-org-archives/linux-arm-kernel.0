From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 18 Dec 2012 17:35:28 +0100
Subject: [PATCH 17/18] arm: mvebu: enable mwifiex driver in mvebu_defconfig
In-Reply-To: <1355841243-3254-18-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1355841243-3254-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1355841243-3254-18-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121218163528.GL3392@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 03:34:02PM +0100, Thomas Petazzoni wrote:
> The Globalscale Mirabox platform, based on the Armada 370 from
> Marvell, has a SD8787 Wireless chip connected on the SDIO
> interface. Now that the mvsdio has a Device Tree binding, and the
> necessary Device Tree informations have been added at the SoC and
> board level, let's enable the mwifiex driver for the Wireless part of
> the SD8787 chip.
> 
> For now, the driver gets probed correctly, detects a device and shows
> the network interfaces. However, scanning Wifi networks doesn't work
> for now, with a 'CMD_RESP: cmd 0x6 error, result=0x1' message. This
> will have to be investigated separately.

Hi Thomas

Sounds similar to what i see on topkick with the mwifiex driver.

       Andrew

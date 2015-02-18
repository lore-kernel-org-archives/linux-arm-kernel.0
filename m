From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 18 Feb 2015 14:54:43 +0100
Subject: [PATCHv3] mvebu: add Linksys WRT1900AC (Mamba) support
In-Reply-To: <1424089864-15651-1-git-send-email-kaloz@openwrt.org>
References: <1424089864-15651-1-git-send-email-kaloz@openwrt.org>
Message-ID: <20150218135443.GJ10224@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 16, 2015 at 01:31:04PM +0100, Imre Kaloz wrote:
> The Linksys WRT1900AC (Mamba) is a router that has
> 
> - 2 mini-PCIe slots with Marvell 88W8864 radios
> - 1 USB 3.0 port
> - 1 USB 2.0/eSATAp port
> - 2 Ethernet interfaces connected to a 88E6172 switch (1x WAN + 4x LAN)
> - 128MB NAND flash
> - 256MB RAM
> 
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>

Hi Imre

This looks good now.

Acked-by: Andrew Lunn <andrew@lunn.ch>

I want to test this, and add a Tested-by:, and add support for the
switch, but i don't have time for this at the moment.

	Andrew

From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 19 Dec 2013 22:21:15 -0500
Subject: [PATCH 1/4] Phy: DT binding documentation for Marvell MVEBU
 SATA phy.
In-Reply-To: <1387311713-1926-1-git-send-email-andrew@lunn.ch>
References: <1387311713-1926-1-git-send-email-andrew@lunn.ch>
Message-ID: <20131220032115.GD2609@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 09:21:49PM +0100, Andrew Lunn wrote:
> Describe the binding for the Marvell MVEBU SATA phy. This driver
> can be used at least with Kirkwood, Dove and maybe others.
> Additionally, update the SATA binding with the properties to link
> to the phy nodes.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v1->v2:
> Correct #phy-cells
> Correct number after @ to match first reg address.
> Rename to phy-mvebu.txt
> 
> v2->v3:
> Renamed to mvebu-phy.txt
> Use "port0", "port1" instead of "0", "1"
> ---
>  Documentation/devicetree/bindings/ata/marvell.txt  |  6 ++++++
>  .../devicetree/bindings/phy/mvebu-phy.txt          | 22 ++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mvebu-phy.txt

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

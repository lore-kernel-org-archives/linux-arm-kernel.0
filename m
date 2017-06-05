From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 5 Jun 2017 23:16:39 +0200
Subject: [PATCH] arm64: dts: marvell: 8040-mcbin: Enable 1GB Ethernet
In-Reply-To: <20170605200107.7692-1-marc.zyngier@arm.com>
References: <20170605200107.7692-1-marc.zyngier@arm.com>
Message-ID: <20170605211639.GB9339@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +&cps_eth1 {
> +	status = "okay";
> +	phy = <&phy0>;
> +	phy-mode = "sgmii";
> +};

Hi Marc

Documentation/devicetree/bindings/net/ethernet.txt says:

- phy-handle: phandle, specifies a reference to a node representing a PHY
  device; this property is described in ePAPR and so preferred;
- phy: the same as "phy-handle" property, not recommended for new bindings.

  Andrew

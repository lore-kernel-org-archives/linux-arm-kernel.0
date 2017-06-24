From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 24 Jun 2017 04:10:52 +0200
Subject: [PATCH 01/11] net: phy: Add rockchip phy driver support
In-Reply-To: <1498192929-7519-2-git-send-email-david.wu@rock-chips.com>
References: <1498192929-7519-1-git-send-email-david.wu@rock-chips.com>
 <1498192929-7519-2-git-send-email-david.wu@rock-chips.com>
Message-ID: <20170624021052.GA4875@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +
> +static int internal_config_init(struct phy_device *phydev)
> +{

internal_ is a bit generic. The Marvell Ethernet switches have
internal phy, etc. rockchip_ would be a better prefix.

	 Andrew

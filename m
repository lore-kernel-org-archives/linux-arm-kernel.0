From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 8 Aug 2016 22:04:39 +0800
Subject: [PATCH 2/3] ARM: dts: imx6sx: Add UDOO Neo support
In-Reply-To: <1467691450-22975-3-git-send-email-afaerber@suse.de>
References: <1467691450-22975-1-git-send-email-afaerber@suse.de>
 <1467691450-22975-3-git-send-email-afaerber@suse.de>
Message-ID: <20160808140439.GH4678@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2016 at 06:04:09AM +0200, Andreas F?rber wrote:
> +&fec1 {
> +	status = "okay";
> +	phy-handle = <&ethphy1>;

We generally have 'status' at the bottom of property list.

Shawn

> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy1: ethernet-phy at 0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +		};
> +	};
> +};

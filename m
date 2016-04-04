From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 4 Apr 2016 14:10:45 +0200
Subject: [PATCH v2] ARM: dts: kirkwood: Add DTS for Linksys EA4200v2/EA4500
In-Reply-To: <1459770433-2876-1-git-send-email-bert@biot.com>
References: <1459770433-2876-1-git-send-email-bert@biot.com>
Message-ID: <20160404121045.GB21828@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 01:47:12PM +0200, Bert Vermeulen wrote:
> This platform is based on a Marvell 88E6282 SoC and 88E6171 switch.
> ---

Hi Bert

Under the --- it is normal to list what you have changed. That helps
the reviewer focus on just the changes.

>  arch/arm/boot/dts/kirkwood-viper.dts | 236 +++++++++++++++++++++++++++++++++++

Please include linksys in the filename.

ls *linksys*
armada-385-linksys-caiman.dts  armada-385-linksys.dtsi
armada-385-linksys-cobra.dts   armada-xp-linksys-mamba.dts

>  1 file changed, 236 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-viper.dts

Please add this file to the Makefile. And keep the entries in
alphabetical order.

Otherwise this looks good.

Thanks
	Andrew

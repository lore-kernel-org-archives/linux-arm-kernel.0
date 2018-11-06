From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 6 Nov 2018 09:34:50 +0100
Subject: [PATCH 2/2] arm64: dts: r8a77990: ebisu: Enable SDHI interfaces
In-Reply-To: <20181105214117.11734-2-marek.vasut+renesas@gmail.com>
References: <20181105214117.11734-1-marek.vasut+renesas@gmail.com>
 <20181105214117.11734-2-marek.vasut+renesas@gmail.com>
Message-ID: <20181106083450.GB1054@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +	sdhi3_pins: sd3 {
> +		groups = "sdhi3_data8", "sdhi3_ctrl";
> +		function = "sdhi3";
> +		power-source = <1800>;
> +	};
> +
> +	sdhi3_pins_uhs: sd3_uhs {
> +		groups = "sdhi3_data8", "sdhi3_ctrl";
> +		function = "sdhi3";
> +		power-source = <1800>;
> +	};

Shouldn't we have only one pinctrl config here, like you did recently
for the other Gen3 SoCs?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181106/af029d94/attachment.sig>

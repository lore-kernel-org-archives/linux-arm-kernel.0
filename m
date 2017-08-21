From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 21 Aug 2017 10:28:42 +0200
Subject: [PATCH  2/3] ARM: dts: iwg20m: Enable SDHI0 controller
In-Reply-To: <1502711389-16040-3-git-send-email-biju.das@bp.renesas.com>
References: <1502711389-16040-1-git-send-email-biju.das@bp.renesas.com>
 <1502711389-16040-3-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20170821082842.GB2418@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +
> +&sdhi0 {
> +	pinctrl-0 = <&sdhi0_pins>;
> +	pinctrl-names = "default";
> +
> +	vmmc-supply = <&reg_3p3v>;
> +	vqmmc-supply = <&reg_3p3v>;
> +	cd-gpios = <&gpio7 11 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};

Just to make sure: No 1.8V and UHS support (SDR50/104)? Or is this to be
tested and added later?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/a3fbe45c/attachment.sig>

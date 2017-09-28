From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Sep 2017 17:12:25 +0200
Subject: [PATCH v2 2/3] ARM: dts: sun8i: Add board dts file for Banana Pi
 M2 Ultra
In-Reply-To: <20170928092543.45648-3-icenowy@aosc.io>
References: <20170928092543.45648-1-icenowy@aosc.io>
 <20170928092543.45648-3-icenowy@aosc.io>
Message-ID: <20170928151225.n4pyvn65u6hvpjd7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 09:25:42AM +0000, Icenowy Zheng wrote:
> +&mmc2 {
> +	vmmc-supply = <&reg_dcdc1>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};

I guess it's an emmc, it doesn't have a vqmmmc regulator?

Looks good otherwise, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170928/8ce65781/attachment-0001.sig>

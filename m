From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Sep 2017 12:17:40 +0200
Subject: [PATCH v2 2/3] ARM: dts: sun8i: Add board dts file for Banana Pi
 M2 Ultra
In-Reply-To: <FCCC8A9F-4818-4CE3-A7E8-62ED9A864F92@aosc.io>
References: <20170928092543.45648-1-icenowy@aosc.io>
 <20170928092543.45648-3-icenowy@aosc.io>
 <20170928151225.n4pyvn65u6hvpjd7@flea>
 <FCCC8A9F-4818-4CE3-A7E8-62ED9A864F92@aosc.io>
Message-ID: <20170929101740.reahjw7wjaspwjld@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 03:38:59PM +0000, Icenowy Zheng wrote:
> 
> 
> ? 2017?9?28? GMT+08:00 ??11:12:25, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
> >On Thu, Sep 28, 2017 at 09:25:42AM +0000, Icenowy Zheng wrote:
> >> +&mmc2 {
> >> +	vmmc-supply = <&reg_dcdc1>;
> >> +	bus-width = <8>;
> >> +	non-removable;
> >> +	status = "okay";
> >> +};
> >
> >I guess it's an emmc, it doesn't have a vqmmmc regulator?
> 
> vqmmc is also 3v3.

You should still put it.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170929/60a8d275/attachment.sig>

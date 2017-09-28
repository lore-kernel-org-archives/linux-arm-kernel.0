From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 28 Sep 2017 23:38:59 +0800
Subject: [PATCH v2 2/3] ARM: dts: sun8i: Add board dts file for Banana Pi
 M2 Ultra
In-Reply-To: <20170928151225.n4pyvn65u6hvpjd7@flea>
References: <20170928092543.45648-1-icenowy@aosc.io>
 <20170928092543.45648-3-icenowy@aosc.io>
 <20170928151225.n4pyvn65u6hvpjd7@flea>
Message-ID: <FCCC8A9F-4818-4CE3-A7E8-62ED9A864F92@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?9?28? GMT+08:00 ??11:12:25, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
>On Thu, Sep 28, 2017 at 09:25:42AM +0000, Icenowy Zheng wrote:
>> +&mmc2 {
>> +	vmmc-supply = <&reg_dcdc1>;
>> +	bus-width = <8>;
>> +	non-removable;
>> +	status = "okay";
>> +};
>
>I guess it's an emmc, it doesn't have a vqmmmc regulator?

vqmmc is also 3v3.

>
>Looks good otherwise, thanks!
>Maxime

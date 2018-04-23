From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 23 Apr 2018 23:04:43 +0800
Subject: [PATCH v3 3/3] ARM: dts: sun8i: h3: Add SY8106A regulator to
 Orange Pi PC
In-Reply-To: <20180423150309.dksr2rjazlrmlzx2@flea>
References: <20180423144657.63264-1-icenowy@aosc.io>
 <20180423144657.63264-4-icenowy@aosc.io>
 <20180423150309.dksr2rjazlrmlzx2@flea>
Message-ID: <34DAE9CF-AB6D-4FB9-9FA6-FAE4E4D2D4C3@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?4?23? GMT+08:00 ??11:03:09, Maxime Ripard <maxime.ripard@bootlin.com> ??:
>On Mon, Apr 23, 2018 at 10:46:57PM +0800, Icenowy Zheng wrote:
>> From: Ondrej Jirman <megous@megous.com>
>> 
>> Add SY8106A regulator to r_i2c bus and enable the r_i2c bus on
>> Orange Pi PC, then set the power supply of the ARM cores to this
>> regulator, in order to enable DVFS.
>> 
>> Signed-off-by: Ondrej Jirman <megous@megous.com>
>> [Icenowy: Enable DVFS in this patch, slight changes and change commit
>>  message]
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>> [wens at csie.org: Rename regulator label]
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
>Why is there Chen-Yu's SoB? It doesn't really make much sense, unless
>Chen-Yu would have applied this patch already, but then you wouldn't
>post it, right?

This is taken from sunxi/h3-h5-for-4.18 branch, which has
label name change from wens, and then added microvolt property.

So his SoB is from when he apply it for the first time.

>
>Maxime 
>
>> ---

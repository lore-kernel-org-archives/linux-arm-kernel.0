From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 26 Feb 2017 17:00:28 +0800
Subject: [PATCH v5 6/7] arm64: dts: allwinner: add Allwinner H5 .dtsi
In-Reply-To: <20170226085553.b6o6mv7ibe5op4dg@localhost>
References: <20170226011956.53581-1-icenowy@aosc.xyz>
 <20170226011956.53581-7-icenowy@aosc.xyz>
 <20170226085553.b6o6mv7ibe5op4dg@localhost>
Message-ID: <CAGb2v67BvVip+CX+HzAf7jAHxpL_EBtbxLxERMHRVv2+zE5Gcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2017 at 4:55 PM, Rask Ingemann Lambertsen
<rask@formelder.dk> wrote:
> On Sun, Feb 26, 2017 at 09:19:55AM +0800, Icenowy Zheng wrote:
>> From: Andre Przywara <andre.przywara@arm.com>
>>
>> The Allwinner H5 SoC is pin-compatible to the H3 SoC, but uses
>> Cortex-A53 cores instead.
>> Based on the now shared base .dtsi describing the common peripherals
>> describe the H5 specific nodes on top of that.
>> That symlinks in the sunxi-h3-h5.dtsi from the arch/arm tree.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> [Icenowy: add H5 pinctrl compatible, and changes for my h3-h5 dtsi
>>  refactor, commit message change to met new arm64 naming scheme,
>
> s/change to met/change to meet/ or s/change to met/changed to meet/ ?
>
>> diff --git a/arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi b/arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi
>> new file mode 120000
>> index 000000000000..036f01dc2b9b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi
>> @@ -0,0 +1 @@
>> +../../../../arm/boot/dts/sunxi-h3-h5.dtsi
>> \ No newline at end of file
>
> But it's missing more than just a newline, isn't it? Shouldn't it read

This is a symbolic link.

>
> #include <../../../../arm/boot/dts/sunxi-h3-h5.dtsi>

This won't work directly with the split out device tree repository,
which has a slightly different layout.

ChenYu

>
> ?
>
> --
> Rask Ingemann Lambertsen

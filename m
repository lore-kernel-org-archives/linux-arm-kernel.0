From: codekipper@gmail.com (Code Kipper)
Date: Wed, 24 Jan 2018 12:40:10 +0100
Subject: [linux-sunxi][PATCH 3/5] arm64: allwinner: a64: Add SPDIF to the
 A64
In-Reply-To: <20180124110124.pgvk7bwesftgbjtj@flea.lan>
References: <20180124103943.2062-1-codekipper@gmail.com>
 <20180124103943.2062-4-codekipper@gmail.com>
 <20180124110124.pgvk7bwesftgbjtj@flea.lan>
Message-ID: <CAEKpxB=aOpnOut-QAB5uDj_WbuPObMpdk9f142ycM3+tB-hDyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 January 2018 at 12:01, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Jan 24, 2018 at 11:39:41AM +0100, codekipper at gmail.com wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> Add the device tree sound bindings for the S/PDIF block.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> ---
>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> index db1694ec3ee4..f060a58f374c 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> @@ -112,6 +112,25 @@
>>               method = "smc";
>>       };
>>
>> +
>> +     sound_spdif {
>
> Nit: You should drop the extra blank line here.
ACK
Thanks,
CK
>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

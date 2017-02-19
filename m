From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 19 Feb 2017 20:58:19 +0300
Subject: [PATCH 1/1] arm64: dts: r8a7795: add IMR-LX4 support
In-Reply-To: <3f007932-d120-b0c0-2080-ce8eeb9418af@cogentembedded.com>
References: <20170214210301.620322370@cogentembedded.com>
 <3f007932-d120-b0c0-2080-ce8eeb9418af@cogentembedded.com>
Message-ID: <d685231a-4509-7728-0f68-29d13703db27@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/2017 12:45 PM, Sergei Shtylyov wrote:

>> Describe the IMR-LX4 devices in the R8A7795 device tree.
>>
>> Based on the original (and large) patch by Konstantin Kozhevnikov
>> <Konstantin.Kozhevnikov@cogentembedded.com>.
>>
>> Signed-off-by: Konstantin Kozhevnikov
>> <Konstantin.Kozhevnikov@cogentembedded.com>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> This patch is against the 'renesas-devel-20170213-v4.10-rc8' tag of Simon
>> Horman's 'renesas.git' repo.
>
>    The binding was documented in the IMR driver patch. I don't expect it to
> change even if the driver would be rewritten for DRM.
>
> [...]
>> Index: renesas/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> ===================================================================
>> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> +++ renesas/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> @@ -1419,6 +1419,38 @@
>>              status = "disabled";
>>          };
>>
>> +        imr-lx4 at fe860000 {
>> +            compatible = "renesas,imr-lx4";
>
>    The manual seems to suggest that IMR-LX4 devicec are different between 7795

    Devices, of course. :-)

> and 7796 SoCs, so we may need SoC specific compatibility. I'll look into this...

    Found no difference between 7795/7796 (other than performance).

MBR, Sergei

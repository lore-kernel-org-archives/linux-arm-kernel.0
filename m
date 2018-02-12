From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Mon, 12 Feb 2018 10:16:03 +0100
Subject: [linux-sunxi] [PATCH v2 5/6] arm64: allwinner: h6: add the
 basical Allwinner H6 DTSI file
In-Reply-To: <a4299cac-84c1-6468-c38a-f232d0dbfb8a@arm.com>
References: <20180203154942.63566-1-icenowy@aosc.io>
 <20180203154942.63566-6-icenowy@aosc.io>
 <a4299cac-84c1-6468-c38a-f232d0dbfb8a@arm.com>
Message-ID: <CAOFm3uHoQcZ3TZg_uTs2aBgU-p0r2ffJ2VLK+E4V19fmLW10WA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Icenowy,

On Mon, Feb 12, 2018 at 12:26 AM, Andr? Przywara <andre.przywara@arm.com> wrote:
> Hi,
>
> On 03/02/18 15:49, Icenowy Zheng wrote:
>> Allwinner H6 is a new SoC with Cortex-A53 cores from Allwinner, with its
>> memory map fully reworked and some high-speed peripherals (PCIe, USB
>> 3.0) introduced.
>>
>> This commit adds the basical DTSI file of it, including the clock
>> support and UART support.
>
> Checked the MMIO addresses and the interrupt numbers against the manual.
>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
>
> Thanks!
> Andre.
>
>> ---
>> Changes in v2:
>> - Add APB1 clock as PIO's APB clock.
>> - Switched to SPDX license identifier.
>>
>>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 178 +++++++++++++++++++++++++++
>>  1 file changed, 178 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> new file mode 100644
>> index 000000000000..d4697bb42496
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> @@ -0,0 +1,178 @@
>> +/*
>> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
>> + *
>> + * SPDX-License-Identifier: (GPL-2.0+ or MIT)
>> + */

Thank you for using SPDX ids: this needs to be on the first line
though! [1] and eventually some special comments style.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst

-- 
Cordially
Philippe Ombredanne

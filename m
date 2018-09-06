From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 06 Sep 2018 14:19:17 +0800
Subject: [linux-sunxi] [PATCH v4 08/11] arm64: dts: allwinner: a64: Add
 display pipeline
In-Reply-To: <CAMty3ZDn=uj3buvJx93R1J7Swr3CyfjJJ=MgQTGvRZ01izbAAA@mail.gmail.com>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-9-icenowy@aosc.io>
 <CAMty3ZDn=uj3buvJx93R1J7Swr3CyfjJJ=MgQTGvRZ01izbAAA@mail.gmail.com>
Message-ID: <73ADC796-D8CE-417C-82E3-0CDAF710A2F3@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?9?6? GMT+08:00 ??2:18:13, Jagan Teki <jagan@amarulasolutions.com> ??:
>On Tue, Sep 4, 2018 at 10:10 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> From: Jagan Teki <jagan@amarulasolutions.com>
>>
>> Allwinner A64 have a display pipeline with 2 mixers/TCONs, the first
>> TCON is connected to LCD and the second is to HDMI.
>>
>> The HDMI controller/PHY pair is similar to the one on H3/H5.
>>
>> Add all required device tree nodes of the display pipeline, including
>> the TCON0 LCD one and the TCON1 HDMI one.
>>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> [Icenowy: refactor commit message and add 1st pipeline]
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>> Changes for v4:
>> - Misc fixes
>> - Dropped second PLL from HDMI PHY clock
>
>Why? it was there in previous versions.

Based on my experiments, the bit has no effect on A64, and the parent
is always PLL-VIDEO0.

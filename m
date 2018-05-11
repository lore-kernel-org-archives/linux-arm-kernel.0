From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 11 May 2018 11:37:04 +0530
Subject: [PATCH v2] arm64: allwinner: a64: Add Amarula A64 Relic initial
 support
In-Reply-To: <CAGb2v67ZDUqLGiWfocZXzGY54dYcSVUMC-xz87xaJQs88-nqyw@mail.gmail.com>
References: <20180511054307.3410-1-jagan@amarulasolutions.com>
 <CAGb2v67ZDUqLGiWfocZXzGY54dYcSVUMC-xz87xaJQs88-nqyw@mail.gmail.com>
Message-ID: <CAMty3ZCM7Sxsp4MwDRYq9NSfWJfj6XKK6JN9DKyk91MNrLvPAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 11:20 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Thu, May 10, 2018 at 10:43 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
>> Amarula A64 Relic is Allwinner A64 based IoT device, which support
>> - Allwinner A64 Cortex-A53
>> - Mali-400MP2 GPU
>> - AXP803 PMIC
>> - 1GB DDR3 RAM
>> - 8GB eMMC
>> - AP6330 Wifi/BLE
>> - MIPI-DSI
>> - CSI: OV5640 sensor
>> - USB OTG
>> - 12V DC power supply
>>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> ---
>> Changes for v2:
>> - Rename dts name to sun50i-a64-relic.dts which is simple to use
>
> This is subjective. For other users this hardly qualifies to
> identify the board. Please keep the vendor / brand name in
> the file name.

Which I thought initially, but adding vendor makes long string which
become lengthy for next boards to add it in future. So we make
notation with <SOC_name>_<board_name> like sun50i-a64-teres-i.dts
does.

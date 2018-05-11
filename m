From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 10 May 2018 22:50:31 -0700
Subject: [PATCH v2] arm64: allwinner: a64: Add Amarula A64 Relic initial
 support
In-Reply-To: <20180511054307.3410-1-jagan@amarulasolutions.com>
References: <20180511054307.3410-1-jagan@amarulasolutions.com>
Message-ID: <CAGb2v67ZDUqLGiWfocZXzGY54dYcSVUMC-xz87xaJQs88-nqyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2018 at 10:43 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> Amarula A64 Relic is Allwinner A64 based IoT device, which support
> - Allwinner A64 Cortex-A53
> - Mali-400MP2 GPU
> - AXP803 PMIC
> - 1GB DDR3 RAM
> - 8GB eMMC
> - AP6330 Wifi/BLE
> - MIPI-DSI
> - CSI: OV5640 sensor
> - USB OTG
> - 12V DC power supply
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - Rename dts name to sun50i-a64-relic.dts which is simple to use

This is subjective. For other users this hardly qualifies to
identify the board. Please keep the vendor / brand name in
the file name.

ChenYu

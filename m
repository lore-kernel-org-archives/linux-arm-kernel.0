From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Mon, 26 Sep 2016 14:19:59 -0500
Subject: [PATCH v2] ARM: dts: socfpga: Add Macnica sodia board
In-Reply-To: <20160924235945.32128-1-iwamatsu@nigauri.org>
References: <20160924235945.32128-1-iwamatsu@nigauri.org>
Message-ID: <57E974DF.4060402@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2016 06:59 PM, Nobuhiro Iwamatsu wrote:
> Add support for board based on the Altera Cyclone V SoC.
> This board has the following functions:
>     - 1 GiB of DRAM
>     - 1 Gigabit ethernet
>     - 1 SD card slot
>     - 1 USB gadget port
>     - QSPI NOR Flash
>     - I2C EEPROMs and I2C RTC
>     - DVI output
>     - Audio port
> 
> This commit supports without QSPI, DVI and Audio.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  V2: move the PHY of setting to the Ethetnet PHY node level.
> 

Applied. Thanks!

Dinh

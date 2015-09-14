From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 Sep 2015 15:24:47 +0800
Subject: [PATCH 5/6] ARM: dts: sun6i: Add support for Sinlinx A31s SDK
 board
In-Reply-To: <20150828123443.GM29389@lukather>
References: <1440755679-8266-1-git-send-email-wens@csie.org>
 <1440755679-8266-6-git-send-email-wens@csie.org>
 <20150828123443.GM29389@lukather>
Message-ID: <CAGb2v64LF39Cj-KWQ5xLF_Pt3yATmzDJMa6XDaizectNRDping@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 28, 2015 at 8:34 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Aug 28, 2015 at 05:54:38PM +0800, Chen-Yu Tsai wrote:
>> The Sinlinx A31s SDK is a A31s based module/baseboard development kit.
>>
>> The core module has the SoC, PMIC, DRAM, eMMC and supporting components.
>> There are also pads for UART0, JTAG and I2S.
>
> Can you use that core module without that baseboard?

You could just solder 5v, gnd, and uart, and it should work.
Not that I actually tried it.

>> The baseboard has 100 Mbps Ethernet, 5x USB 2.0 host ports via a USB 2.0
>> hub chip, MMC, HDMI, SPDIF, CIR, audio jacks, 2 tablet-like volume
>> buttons, RS232 style UART and USB OTG (though VBUS is not connected).
>> Various headers are available for other addon modules, such as SDIO
>> WiFi, LCD display, camera sensor, UARTs, I2C, SPI and GPIOs.
>
> Can the baseboard be used with our core modules?

Doubtful. The baseboard is more like a demonstration platform for the
core board.

What do you suggest?


ChenYu

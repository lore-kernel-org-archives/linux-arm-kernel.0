From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Thu, 18 Aug 2016 10:01:30 -0500
Subject: [PATCH] ARM: dts: socfpga: Add Macnica sodia board
In-Reply-To: <32814CCC-93D0-4D39-8CE8-89F17D742583@gmail.com>
References: <1469482208-5071-1-git-send-email-iwamatsu@nigauri.org>
 <57AE2951.3050404@opensource.altera.com>
 <32814CCC-93D0-4D39-8CE8-89F17D742583@gmail.com>
Message-ID: <57B5CDCA.8020703@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2016 03:26 PM, Florian Fainelli wrote:
> On August 12, 2016 12:53:53 PM MST, Dinh Nguyen <dinguyen@opensource.altera.com> wrote:
>> On 07/25/2016 04:30 PM, Nobuhiro Iwamatsu wrote:
>>> Add support for board based on the Altera Cyclone V SoC.
>>> This board has the following functions:
>>>     - 1 GiB of DRAM
>>>     - 1 Gigabit ethernet
>>>     - 1 SD card slot
>>>     - 1 USB gadget port
>>>     - QSPI NOR Flash
>>>     - I2C EEPROMs and I2C RTC
>>>     - DVI output
>>>     - Audio port
>>>
>>> This commit supports without QSPI, DVI and Audio.
>>>
>>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>>> ---
>>>  arch/arm/boot/dts/Makefile                   |   1 +
>>>  arch/arm/boot/dts/socfpga_cyclone5_sodia.dts | 115
>> +++++++++++++++++++++++++++
>>>  2 files changed, 116 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
>>>
>>
>> Applied!
> 
> This DTS still has Ethernet PHY properties (skew et al.) that are at the Ethernet MAC node level while they should be at the Ethetnet PHY node level, it is not like you tripped over that before..
> 

Thanks for catching this.

Nobuhiro, can you please fixup the ethernet node?

Thanks,
Dinh

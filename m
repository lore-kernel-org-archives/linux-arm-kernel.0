From: marex@denx.de (Marek Vasut)
Date: Fri, 22 Apr 2016 17:45:43 +0200
Subject: [PATCH] ARM: socfpga: dts: Add samtec VIN|ING board
In-Reply-To: <571A3D4C.4050807@opensource.altera.com>
References: <1460550298-9533-1-git-send-email-marex@denx.de>
 <571A3D4C.4050807@opensource.altera.com>
Message-ID: <571A4727.6020008@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2016 05:03 PM, Dinh Nguyen wrote:
> On 04/13/2016 07:24 AM, Marek Vasut wrote:
>> Add support for board based on the popular Altera Cyclone V SoC.
>> This board has the following properties:
>>  - 1 GiB of DRAM
>>  - 1 Gigabit ethernet
>>  - 1 USB gadget port
>>  - 1 USB host port with an on-board hub
>>  - 2 QSPI NORs connected to the Cadence QSPI core
>>  - Multiple I2C EEPROMs and one I2C temperature sensor
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
>> ---
>>  arch/arm/boot/dts/Makefile                         |   1 +
>>  arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 310 +++++++++++++++++++++
>>  2 files changed, 311 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
> 
> Minor nit for next time. The arm-soc maintainers would like the commit
> head for DTS to be: "ARM: dts: <platform>".

Ha, thanks for the update. I wasn't aware of the ordering requirement.

> I fixed it up and applied.
> 
> Thanks,
> Dinh
> 


-- 
Best regards,
Marek Vasut

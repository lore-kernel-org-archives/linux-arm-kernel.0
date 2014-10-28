From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 28 Oct 2014 16:16:44 -0500
Subject: [PATCH] ARM: socfpga_defconfig: Update defconfig for SoCFPGA
In-Reply-To: <2864980.6A4UvhQCUL@wuerfel>
References: <1413985972-28735-1-git-send-email-dinguyen@opensource.altera.com>
 <2864980.6A4UvhQCUL@wuerfel>
Message-ID: <545007BC.9070508@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2014 04:13 PM, Arnd Bergmann wrote:
> On Wednesday 22 October 2014 08:52:52 dinguyen at opensource.altera.com wrote:
>> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>>
>> Clean up the socfpga_defconfig file by doing:
>>         make socfpga_defconfig
>>         make
>>         make savedefconfig
>>
>> Then add the following to socfpga_defconfig:
>>
>> CONFIG_SIGNALFD=y
>> CONFIG_REGULATOR=y
>> CONFIG_REGULATOR_FIXED_VOLTAGE=y
>> CONFIG_SRAM=y
>> CONFIG_DEVTMPFS_MOUNT=y
>> CONFIG_CONFIGFS_FS=y
>> CONFIG_PMBUS=y
>> CONFIG_SENSORS_PMBUS=y
>> CONFIG_SENSORS_LTC2978=y
>> CONFIG_SENSORS_LTC2978_REGULATOR=y
>> CONFIG_PRINTK_TIME=y
>>
>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>> Signed-off-by: Alan Tull <atull@opensource.altera.com>
>> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> 
> Did you mean this patch to be picked up for 3.19, or just reviewed?
> 

Yes, I meant for it to get picked up for 3.19. Olof has already picked it.

Dinh

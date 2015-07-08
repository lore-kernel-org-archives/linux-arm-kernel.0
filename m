From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 08 Jul 2015 10:36:13 +0200
Subject: [PATCH] arm64: defconfig: Add Ceva ahci to the defconfig
In-Reply-To: <20150706162645.GG27723@e104818-lin.cambridge.arm.com>
References: <457a921583db64bf74ae13b227bedf79cf86cff8.1435554123.git.michal.simek@xilinx.com>
 <20150706162645.GG27723@e104818-lin.cambridge.arm.com>
Message-ID: <559CE0FD.6020509@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 07/06/2015 06:26 PM, Catalin Marinas wrote:
> On Mon, Jun 29, 2015 at 07:02:08AM +0200, Michal Simek wrote:
>> From: Suneel Garapati <suneel.garapati@xilinx.com>
>>
>> The Ceva ahci controller is available on the Xilinx Zynq UltraScale+
>> MPSoC.
>>
>> Signed-off-by: Suneel Garapati <suneel.garapati@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  arch/arm64/configs/defconfig | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index f38c94f1d898..ef5b5d27a226 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -82,7 +82,7 @@ CONFIG_BLK_DEV_SD=y
>>  # CONFIG_SCSI_LOWLEVEL is not set
>>  CONFIG_ATA=y
>>  CONFIG_SATA_AHCI=y
>> -CONFIG_SATA_AHCI_PLATFORM=y
>> +CONFIG_AHCI_CEVA=y
> 
> Any reason why CONFIG_SATA_AHCI_PLATFORM is removed by this patch?

that's bug. :-( I thought that there was dependency but that's not truth.

> 
> I merged the patch but modified it to only add CONFIG_AHCI_CEVA without
> changing any other lines.

Thank you so much.

Thanks,
Michal

From: anuragku@xilinx.com (Anurag Kumar Vulisha)
Date: Tue, 11 Sep 2018 08:04:41 +0000
Subject: [PATCH v3 1/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy
 core
In-Reply-To: <20180910201523.GA4024@bogus>
References: <1536165747-6405-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1536165747-6405-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <20180910201523.GA4024@bogus>
Message-ID: <BN3PR0201MB09937FA5CE658BFD974146CBA7040@BN3PR0201MB0993.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Rob,

Thanks a lot for spending your time in reviewing this patch series, 

>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>> ---
>> Changes in v3:
>> 	1. Corrected the Documentation as suggested by Vivek Gautam
>>
>> Changes in v2:
>> 	1. Fixed the compilation error when compiled phy-zynqmp.c as a module
>> 	2. Added CONFIG_PM macro in phy-zynqmp.c driver
>> ---
>>  drivers/phy/Kconfig            |    8 +
>>  drivers/phy/Makefile           |    1 +
>>  drivers/phy/phy-zynqmp.c       | 1581
>++++++++++++++++++++++++++++++++++++++++
>>  include/dt-bindings/phy/phy.h  |    2 +
>
>This goes in patch 2. And patch 2 should come first.
>

Will fix this in the next series of the patch

Thanks,
Anurag Kumar Vulisha

>>  include/linux/phy/phy-zynqmp.h |   52 ++
>>  5 files changed, 1644 insertions(+)
>>  create mode 100644 drivers/phy/phy-zynqmp.c  create mode 100644
>> include/linux/phy/phy-zynqmp.h

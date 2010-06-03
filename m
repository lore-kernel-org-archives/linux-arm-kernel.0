From: jason77.wang@gmail.com (jason)
Date: Thu, 03 Jun 2010 22:39:42 +0800
Subject: [V2 1/3] mxc: Add support for the imx51 3-stack board
In-Reply-To: <20100603123908.GB3527@matterhorn.lan>
References: <1275566746-6510-1-git-send-email-jason77.wang@gmail.com>
	<1275566746-6510-2-git-send-email-jason77.wang@gmail.com>
	<20100603123908.GB3527@matterhorn.lan>
Message-ID: <4C07BEAE.7020205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amit Kucheria wrote:
> Two comments inline.
>
> On 10 Jun 03, Jason Wang wrote:
>   
>> 3-stack is a reference board from Freescale for their i.MX51 SoC.
>>
>> Add board definition, Kconfig and Makefile to enable Freescale 3-stack
>> board.
>>
>> Boot tested on a i.MX51 3-stack Rev2.0 board
>>
>> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>> ---
>>  arch/arm/mach-mx5/Kconfig                       |    5 +
>>  arch/arm/mach-mx5/Makefile                      |    2 +-
>>  arch/arm/mach-mx5/board-mx51_3ds.c              |  263 +++++++++++++++++++++++
>>  arch/arm/plat-mxc/include/mach/board-mx51_3ds.h |   70 ++++++
>>  arch/arm/plat-mxc/include/mach/iomux-mx51.h     |   10 +-
>>  5 files changed, 345 insertions(+), 5 deletions(-)
>>  create mode 100644 arch/arm/mach-mx5/board-mx51_3ds.c
>>  create mode 100644 arch/arm/plat-mxc/include/mach/board-mx51_3ds.h
>>
>>     
>>     
<snip>
>> diff --git a/arch/arm/plat-mxc/include/mach/board-mx51_3ds.h b/arch/arm/plat-mxc/include/mach/board-mx51_3ds.h
>> new file mode 100644
>> index 0000000..035f7bc
>> --- /dev/null
>> +++ b/arch/arm/plat-mxc/include/mach/board-mx51_3ds.h
>> @@ -0,0 +1,70 @@
>> +/*
>> + * Copyright 2008-2009 Freescale Semiconductor, Inc. All Rights Reserved.
>> + *
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>> +
>> +#ifndef __ASM_ARCH_MXC_BOARD_MX51_3DS_H__
>> +#define __ASM_ARCH_MXC_BOARD_MX51_3DS_H__
>> +
>> +/*
>> + * @file plat-mxc/include/mach/board-mx51_3ds.h
>> + *
>> + * @brief This file contains all the board level configuration options.
>>     
>
> Remove this @file, @brief.
>
>   
OK, i will fix it in V3.

Thanks,
Jason.
>> + * It currently hold the options defined for MX51 3Stack Platform.
>> + *
>> + */
>> +
>> +#define DEBUG_BOARD_BASE_ADDRESS MX51_CS5_BASE_ADDR
>>     
>
<snip>

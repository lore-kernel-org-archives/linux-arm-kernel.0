From: huziji@marvell.com (Ziji Hu)
Date: Sat, 8 Oct 2016 08:59:57 +0800
Subject: [PATCH 4/10] MAINTAINERS: add entry for Marvell Xenon MMC Host
 Controller drivers
In-Reply-To: <1475873086.1945.20.camel@perches.com>
References: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
 <86b237c01d9767d4e0edf6d41194ab959838e5c0.1475853198.git-series.gregory.clement@free-electrons.com>
 <1475873086.1945.20.camel@perches.com>
Message-ID: <05c3c587-96ee-94e9-8508-54d048ab297a@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

On 2016/10/8 4:44, Joe Perches wrote:
> On Fri, 2016-10-07 at 17:22 +0200, Gregory CLEMENT wrote:
>> Add maintainer entry for Marvell Xenon eMMC/SD/SDIO Host
>> Controller drivers.
> []
>> diff --git a/MAINTAINERS b/MAINTAINERS
> []
>> @@ -7578,6 +7578,11 @@ M:	Nicolas Pitre <nico@fluxnic.net>
>>  S:	Odd Fixes
>>  F:	drivers/mmc/host/mvsdio.*
>>  
>> +MARVELL XENON MMC/SD/SDIO HOST CONTROLLER DRIVER
>> +M:	Ziji Hu <huziji@marvell.com>
>> +L:	linux-mmc at vger.kernel.org
>> +S:	Supported
> 
> You should really add F: file patterns here
> 
	The specific file patterns will be added later when the corresponding file is included in patch.
	Otherwise, it cannot pass checkpatch.pl.

	Thank you.

Best regards,
Hu Ziji

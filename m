From: york.sun@nxp.com (york sun)
Date: Mon, 8 Aug 2016 15:16:53 +0000
Subject: [Patch v3 10/11] driver/edac/layerscape_edac: Add Layerscape EDAC
 support
References: <1470351518-22404-1-git-send-email-york.sun@nxp.com>
 <1470351518-22404-11-git-send-email-york.sun@nxp.com>
 <19101224.m7ryErTDyD@ws-stein>
Message-ID: <AM4PR0401MB173245DF98E6A42A05DB4B299A1B0@AM4PR0401MB1732.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2016 01:57 AM, Alexander Stein wrote:
> On Thursday 04 August 2016 15:58:35, York Sun wrote:
>> Add DDR EDAC for ARM-based compatible controllers. Both big-endian
>> and little-endian are supported.
>>
>> Signed-off-by: York Sun <york.sun@nxp.com>
>>
>> ---
>> Change log
>>   v3: no change
>>   v2: Create new driver using shared DDR object
>>
>>  arch/arm64/Kconfig.platforms           |  1 +
>>  arch/{arm => arm64}/include/asm/edac.h | 21 +++++------
>>  arch/arm64/include/asm/irq.h           |  4 ++
>>  drivers/edac/Kconfig                   |  7 ++++
>>  drivers/edac/Makefile                  |  3 ++
>>  drivers/edac/fsl_ddr_edac.c            |  1 +
>>  drivers/edac/layerscape_edac.c         | 67
>> ++++++++++++++++++++++++++++++++++ 7 files changed, 92 insertions(+), 12
>> deletions(-)
>>  copy arch/{arm => arm64}/include/asm/edac.h (79%)
>>  create mode 100644 drivers/edac/layerscape_edac.c
>
> This only adds EDAC support for ARM64. What would be necessary for ARM
> support, e.g. LS1021A?
>

It should be just one step away. I haven't got a chance to verify/debug 
it on LS1021A.

York

From: roy.pledge@nxp.com (Roy Pledge)
Date: Tue, 24 Jul 2018 14:26:46 +0000
Subject: [PATCH v2 4/4] drivers/soc/fsl/dpio: Convert DPIO documentation
 to .rst
References: <20180723170025.2259-1-roy.pledge@nxp.com>
 <20180723170025.2259-5-roy.pledge@nxp.com>
 <VI1PR0402MB348590E265D062CFC83F7FDF98550@VI1PR0402MB3485.eurprd04.prod.outlook.com>
Message-ID: <VI1PR04MB44946C75CDD8BB0DB337181886550@VI1PR04MB4494.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/24/2018 9:52 AM, Horia Geanta wrote:
> On 7/23/2018 8:00 PM, Roy Pledge wrote:
>> Convert the Datapath I/O documentation to .rst format
>> and move to the Documation/networking/dpaa2 directory
> typo:             ^^^ Documentation
>
>> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
>> ---
>>  .../networking/dpaa2/dpio-driver.rst               | 30 +++++++++++++++++++---
>>  Documentation/networking/dpaa2/index.rst           |  1 +
>>  2 files changed, 28 insertions(+), 3 deletions(-)
>>  rename drivers/soc/fsl/dpio/dpio-driver.txt => Documentation/networking/dpaa2/dpio-driver.rst (94%)
>>
>> diff --git a/drivers/soc/fsl/dpio/dpio-driver.txt b/Documentation/networking/dpaa2/dpio-driver.rst
>> similarity index 94%
>> rename from drivers/soc/fsl/dpio/dpio-driver.txt
>> rename to Documentation/networking/dpaa2/dpio-driver.rst
>> index 72ba9da..3a33a33 100644
>> --- a/drivers/soc/fsl/dpio/dpio-driver.txt
>> +++ b/Documentation/networking/dpaa2/dpio-driver.rst
>> @@ -1,7 +1,16 @@
>> -Copyright 2016 NXP
>> +.. include:: <isonum.txt>
>> +
>> +DPAA2 DPIO (Data Path I/O) Overview
>> +===================================
>> +
>> +:Copyright: |copy| 2015 Freescale Semiconductor Inc.
>> +:Copyright: |copy| 2018 NXP
>> +
> Existing copyright should be kept.
> 2018 could be appended if needed.
I have resent v3 to address this oversight.

Thanks

Roy
> Regards,
> Horia
>

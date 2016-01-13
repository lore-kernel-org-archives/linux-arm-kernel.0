From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 13 Jan 2016 11:13:49 +0900
Subject: [PATCH v3 0/2] power: act8945a: add charger driver for the
 sub-device of ACT8945A MFD
In-Reply-To: <5695ACE7.3050505@samsung.com>
References: <1452586185-818-1-git-send-email-wenyou.yang@atmel.com>
 <5695ACE7.3050505@samsung.com>
Message-ID: <5695B2DD.3000504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.01.2016 10:48, Krzysztof Kozlowski wrote:
> On 12.01.2016 17:09, Wenyou Yang wrote:
>> The ACT8945A is a Multi Function Device with the following subdevices:
>>  - Regulator
>>  - Charger
>>
>> This patch set is to add regulator driver for ACT8945A.
>> It is based on the patch set:
>> 	[PATCH v2] mfd: act8945a: add Active-semi ACT8945A PMIC MFD driver
>>
> 
> The useful information would be can be applied independently to other
> tree than MFD.

Oh damn, that was far from English. I meant:

The useful information would be whether it can be applied independently
from that patchset.

>From the sentence above I would guess not (in that
case don't send it as separate patchset)... but from the code I think it
could (because it depends on MFD_ACT8945A so no build errors).

Anyway please mark it explicitly - it helps the maintainer to make the
decision.

Best regards,
Krzysztof

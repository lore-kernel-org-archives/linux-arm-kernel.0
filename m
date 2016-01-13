From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 13 Jan 2016 10:48:23 +0900
Subject: [PATCH v3 0/2] power: act8945a: add charger driver for the
 sub-device of ACT8945A MFD
In-Reply-To: <1452586185-818-1-git-send-email-wenyou.yang@atmel.com>
References: <1452586185-818-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <5695ACE7.3050505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.01.2016 17:09, Wenyou Yang wrote:
> The ACT8945A is a Multi Function Device with the following subdevices:
>  - Regulator
>  - Charger
> 
> This patch set is to add regulator driver for ACT8945A.
> It is based on the patch set:
> 	[PATCH v2] mfd: act8945a: add Active-semi ACT8945A PMIC MFD driver
> 

The useful information would be can be applied independently to other
tree than MFD. From the sentence above I would guess that not (in that
case don't send it as separate patchset)... but from the code I think it
could (because it depends on MFD_ACT8945A).

Anyway please mark it explicitly - it helps the maintainer.

Best regards,
Krzysztof

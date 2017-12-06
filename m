From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Wed, 6 Dec 2017 18:46:19 +0100
Subject: [PATCH v4 0/5] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <SN1PR0101MB15656E4944DE6CAC67D18B07D03D0@SN1PR0101MB1565.prod.exchangelabs.com>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171130235140.12243-1-lukma@denx.de>
 <SN1PR0101MB15656E4944DE6CAC67D18B07D03D0@SN1PR0101MB1565.prod.exchangelabs.com>
Message-ID: <3c3d9bdd-ea95-9fcd-a444-7cf2db3804a7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Hartley,

On 05/12/17 19:14, Hartley Sweeten wrote:
>> This patch series adds support for Liebherr's BK3 board, being a derivative of TS72XX design.
>>
>> This patchset consists of following patches:
>>
>> - ts72xx.[c|h] cosmetic cleanup/improvement
>> - Rewrite ts72xx.c to be reusable by bk3
>> - The Liebherr's BK3 board has been added with re-using code of
>>   ts72xx.c (detalied list of changes can be found in patch 6/6)
>>
>> This series applies on top of linux-next/master (next-20171130)
>>
>> Lukasz Majewski (5):
>>   ARM: ep93xx: ts72xx: Provide include guards for ts72xx.h file
>>   ARM: ep93xx: ts72xx: Rewrite ts72xx_register_flash() to accept
>>     parameters
>>   ARM: ep93xx: ts72xx: Rewrite map IO code to be reusable
>>   ARM: ep93xx: ts72xx: cosmetic: Add some description to ts72xx code
>>   ARM: ep93xx: ts72xx: Add support for BK3 board - ts72xx derivative
>>
>>  MAINTAINERS                   |   6 ++
>>  arch/arm/mach-ep93xx/Kconfig  |   7 ++
>>  arch/arm/mach-ep93xx/ts72xx.c | 198 ++++++++++++++++++++++++++++++++++++++----
>>  arch/arm/mach-ep93xx/ts72xx.h |   9 ++
>>  arch/arm/tools/mach-types     |   1 +
>>  5 files changed, 202 insertions(+), 19 deletions(-)
> Looks good.
> 
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

I can prepare pull request to Arnd, as we discussed previously, just
waited for your review.

Regards,
Alexander.

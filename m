From: thomas.ab@samsung.com (Thomas Abraham)
Date: Mon, 2 Nov 2009 15:11:15 +0900
Subject: [PATCH 2/7] S3C64XX: Add MEM_SYS_CFG register definition.
In-Reply-To: <20091101130228.GH8096@trinity.fluff.org>
References: <1257051031-8074-1-git-send-email-thomas.ab@samsung.com>
	<20091101130228.GH8096@trinity.fluff.org>
Message-ID: <84c135f50911012211m47f1c36ie4a94212a7f5447c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 1, 2009 at 10:02 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Sun, Nov 01, 2009 at 01:50:31PM +0900, Thomas Abraham wrote:
>> This patch adds the definition of MEM_SYS_CFG register for
>> S3C64xx platform.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> ---
>> ?arch/arm/plat-s3c64xx/include/plat/regs-clock.h | ? ?3 +++
>> ?1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
>> index 2c3224c..ad0823e 100644
>> --- a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
>> +++ b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
>> @@ -15,6 +15,8 @@
>> ?#ifndef __PLAT_REGS_CLOCK_H
>> ?#define __PLAT_REGS_CLOCK_H __FILE__
>>
>> +#include <plat/map-base.h>
>> +
>
> Why are you adding <plat/map-base.h> here?
>

I will remove it. That was a mistake.

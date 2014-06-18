From: lho@apm.com (Loc Ho)
Date: Wed, 18 Jun 2014 15:18:26 -0700
Subject: [PATCH v3 3/4] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <20140618221046.GL24024@pd.tnic>
References: <1401761660-11515-1-git-send-email-lho@apm.com>
 <1401761660-11515-2-git-send-email-lho@apm.com>
 <1401761660-11515-3-git-send-email-lho@apm.com>
 <1401761660-11515-4-git-send-email-lho@apm.com>
 <20140618221046.GL24024@pd.tnic>
Message-ID: <CAPw-ZTm9SVpAmuwc1UaKdfphPUEU31-JpmMMOKD3axxX4s2N+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> This patch adds support for the APM X-Gene SoC EDAC driver and
>> requires ARM64 EDAC support patch [1] to compile.
>>
>> [1] http://www.spinics.net/lists/arm-kernel/msg324093.html
>>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> Signed-off-by: Loc Ho <lho@apm.com>
>
> This is starting to look ok, I'd guess it needs to go after the atomic
> scrub patch goes in, right?

Yes... The scrub code needs to be in for compiling only.

>
> Also, I'd need the device tree pieces acked by device tree maintainers
> before I pick them up together with this driver.

Should I ping a device tree maintainer? If so, who would that be?

-Loc

From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 15 Apr 2016 18:41:17 +0100
Subject: [PATCH V2 03/15] coresight: tmc: re-implementing
 tmc_read_prepare/unprepare() functions
In-Reply-To: <CANLsYkzm+=Aec+bXp7htTwr6O3ObSjaQJmSUTjgr608gH7Abhg@mail.gmail.com>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-4-git-send-email-mathieu.poirier@linaro.org>
 <570FCF45.8010809@arm.com>
 <CANLsYkzm+=Aec+bXp7htTwr6O3ObSjaQJmSUTjgr608gH7Abhg@mail.gmail.com>
Message-ID: <571127BD.5030107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/04/16 16:40, Mathieu Poirier wrote:
> On 14 April 2016 at 11:11, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:

>>
>> Nit. If you move the TMC_CONFIG_TYPE_ETB here, you could fall through from
>> TYPE_ETF: i.e,
>
> Yes, that's what the end result look like [1].  I will refactor to
> make the transition cleaner.
>
> [1]. https://git.linaro.org/kernel/coresight.git/blob/refs/heads/next:/drivers/hwtracing/coresight/coresight-tmc.c#l76

Ok, no need to refactor here then.

>>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Cheers
Suzuki

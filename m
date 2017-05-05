From: hotran@apm.com (Hoan Tran)
Date: Fri, 5 May 2017 08:48:28 -0700
Subject: [PATCH v2 0/3] perf: xgene: Add support for SoC PMU version 3
In-Reply-To: <CAFHUOYzJ1PoUV=BmcVxSHZ_8qENm6DW5_Hd3uuFHE9kdqhXCzA@mail.gmail.com>
References: <1491238077-20666-1-git-send-email-hotran@apm.com>
 <CAFHUOYzJ1PoUV=BmcVxSHZ_8qENm6DW5_Hd3uuFHE9kdqhXCzA@mail.gmail.com>
Message-ID: <CAFHUOYw3WtTB+q+zKdRDBaXyCaDp+r-YfydTxHSRm5CT6sNnXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping!

Thanks
Hoan

On Thu, Apr 13, 2017 at 10:50 AM, Hoan Tran <hotran@apm.com> wrote:
> Hi All,
>
> Do you have any comments on this patch set?
>
> Thanks
> Hoan
>
> On Mon, Apr 3, 2017 at 9:47 AM, Hoan Tran <hotran@apm.com> wrote:
>>
>> This patch set adds support for SoC-wide (AKA uncore) Performance
>> Monitoring
>> Unit version 3.
>>
>> It can support up to
>>  - 2 IOB PMU instances
>>  - 8 L3C PMU instances
>>  - 2 MCB PMU instances
>>  - 8 MCU PMU instances
>>
>> v2:
>>  * Split into separate patches
>>  * Use the function pointers for the PMU leaf functions
>>  * Parse PMU subnode by the match table
>>  * Dont allow user change agent id by config1 for SoC PMU v3
>>
>> Hoan Tran (3):
>>   perf: xgene: Parse PMU subnode from the match table
>>   perf: xgene: Move PMU leaf functions into function pointer structure
>>   perf: xgene: Add support for SoC PMU version 3
>>
>>  drivers/perf/xgene_pmu.c | 695
>> +++++++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 619 insertions(+), 76 deletions(-)
>>
>> --
>> 1.9.1
>>
>

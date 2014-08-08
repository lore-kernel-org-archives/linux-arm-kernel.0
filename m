From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 8 Aug 2014 07:55:54 -0600
Subject: [PATCH 07/10 v3] coresight-etm: add CoreSight ETM/PTM driver
In-Reply-To: <53E4600C.4030505@de.bosch.com>
References: <1407435706-19441-1-git-send-email-mathieu.poirier@linaro.org>
 <1407435706-19441-8-git-send-email-mathieu.poirier@linaro.org>
 <53E4600C.4030505@de.bosch.com>
Message-ID: <CANLsYkzDbOyBbqMCp41nt6e84MSCJTWnRDZ0JBJ1jYgtL3ZPFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 August 2014 23:28, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> On 07.08.2014 20:21, mathieu.poirier at linaro.org wrote:
>>
>> From: Pratik Patel <pratikp@codeaurora.org>
>>
>> This driver manages CoreSight ETM (Embedded Trace Macrocell) that
>> supports processor tracing. Currently supported version are ARM
>> ETMv3.x and PTM1.x.
>>
>> Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
>> Signed-off-by: Panchaxari Prasannamurthy
>> <panchaxari.prasannamurthy@linaro.org>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>
> ...
>>
>> +static struct amba_id etm_ids[] = {
>> +       {       /* ETM 3.3 */
>> +               .id     = 0x0003b921,
>> +               .mask   = 0x0003ffff,
>> +       },
>> +       {       /* ETM 3.5 */
>> +               .id     = 0x0003b956,
>> +               .mask   = 0x0003ffff,
>> +       },
>> +       {       /* PTM */
>> +               .id     = 0x0003b95f,
>> +               .mask   = 0x0003ffff,
>> +       },
>> +       { 0, 0},
>
>
> Maybe you like to add PTM 1.0 [1] here, too?

You got it.

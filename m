From: ttnguyen@apm.com (Tai Tri Nguyen)
Date: Wed, 6 Jul 2016 17:35:08 -0700
Subject: [PATCH v7 1/4] MAINTAINERS: Add entry for APM X-Gene SoC PMU
 driver
In-Reply-To: <1467850751.8360.56.camel@perches.com>
References: <1467850045-10584-1-git-send-email-ttnguyen@apm.com>
 <1467850045-10584-2-git-send-email-ttnguyen@apm.com>
 <1467850751.8360.56.camel@perches.com>
Message-ID: <CACgAJHyvusvRPKNaxHLFK=gWw2UUtjV80H175eRu6EieutxNiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

Thanks.

On Wed, Jul 6, 2016 at 5:19 PM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2016-07-06 at 17:07 -0700, Tai Nguyen wrote:
>> Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
>> ---
>>  MAINTAINERS | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
> []
>> @@ -8593,6 +8593,14 @@ L:     linux-scsi at vger.kernel.org
>>  S:   Supported
>>  F:   drivers/scsi/pm8001/
>>
>> +PMU-XGENE
>> +APPLIED MICRO (APM) X-GENE SOC PMU
>
> One line section header please.

Is this strictly required?
I think I can just drop the first line "PMU-XGENE" if it's required.

>
>> +M:   Tai Nguyen <ttnguyen@apm.com>
>> +S:   Supported
>> +F:   drivers/perf/xgene_pmu.c
>> +F:   Documentation/perf/xgene-pmu.txt
>> +F:   Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
>> +
>>  POSIX CLOCKS and TIMERS
>>  M:   Thomas Gleixner <tglx@linutronix.de>
>>  L:   linux-kernel at vger.kernel.org

Regards,
-- 
Tai

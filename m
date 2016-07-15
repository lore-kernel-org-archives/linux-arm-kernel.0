From: fu.wei@linaro.org (Fu Wei)
Date: Fri, 15 Jul 2016 09:02:48 +0800
Subject: [PATCH v7 5/9] MAINTAINERS / ACPI: add the ARM64-specific ACPI
 Support maintainers
In-Reply-To: <CAJZ5v0gut2uCFHa7hr8iKY4ioP4q17yo=gBxJEeZf5WvVNM7pQ@mail.gmail.com>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
 <1468432402-4872-6-git-send-email-fu.wei@linaro.org>
 <CAJZ5v0gut2uCFHa7hr8iKY4ioP4q17yo=gBxJEeZf5WvVNM7pQ@mail.gmail.com>
Message-ID: <CADyBb7sU738DmTrEA-xgpqcWbMJ+ebkzJnPQJH22a7TF9pRJTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On 14 July 2016 at 04:16, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Jul 13, 2016 at 7:53 PM,  <fu.wei@linaro.org> wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This patch add the ARM64-specific ACPI Support maintainers in
>> MAINTAINERS, according to the discussion on mailing list:
>> https://lkml.org/lkml/2016/6/29/580
>> Lorenzo Pieralisi will submit the pull requsts.
>>
>> The maintainers are listed by the alphabet order of
>> their name.
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  MAINTAINERS | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1209323..1e03463 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -315,6 +315,14 @@ W: https://01.org/linux-acpi
>>  S:     Supported
>>  F:     drivers/acpi/fan.c
>>
>> +ACPI FOR ARM64 (ACPI/arm64)
>> +M:     Hanjun Guo <hanjun.guo@linaro.org>
>> +M:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> +M:     Sudeep Holla <sudeep.holla@arm.com>
>> +L:     linux-acpi at vger.kernel.org
>> +S:     Supported
>> +F:     drivers/acpi/arm64
>> +
>>  ACPI THERMAL DRIVER
>>  M:     Zhang Rui <rui.zhang@intel.com>
>>  L:     linux-acpi at vger.kernel.org
>> --
>
> This patch should not be part of your series.
>
> I would prefer it if  Hanjun, Lorenzo or Sudeep sent it.

Sorry for that, This won't be in my patchset next time.

>
> Of course, it doesn't make much sense to send it before creating
> drivers/acpi/arm64/ and putting something in there, so it should be
> sent separately after the series has been merged.

yes, you are right , got it , thanks  :-)

>
> Thanks,
> Rafael



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat

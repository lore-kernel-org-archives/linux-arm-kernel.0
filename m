From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Mon, 10 Nov 2014 10:51:10 -0800
Subject: [PATCH v4 0/2] ARM: keystone: pm: switch to use generic pm domains
In-Reply-To: <5460D601.70504@ti.com>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com>
 <5460D601.70504@ti.com>
Message-ID: <5461091E.6090708@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/14 7:13 AM, Grygorii Strashko wrote:
> Hi Santosh,
>
> On 11/10/2014 04:59 PM, Grygorii Strashko wrote:
>> Hi Santosh, Kevin,
>>
>> This series switches Keystone 2 PM code to use Generic PM domains
>> instead of PM clock domains because of the lack of DT support
>> for the last.
>> It will finally allow to enable Runtime PM for Keystone 2.
>>
>> This series based on top
>>
>> Changes in v4:
>>    - changes for Generic clock manipulation PM callbacks (clock_ops.c)
>>      were separated in standalone series [3] and Keystone 2 specific
>>      patches were rebased on top of it.
>
> I've just found that prerequisite patches have been taken by Rafael in linux-pm.git/linux-next,
> first two patches from series:
>   "[PATCH v4 0/3] PM / clock_ops: add pm_clk_add_clk()"
>   https://lkml.org/lkml/2014/11/6/319
>
> Thanks a lot Rafael.
>
> So, if no complains, this series is ready.
>
Thanks for the note and good to see the series is converged. To avoid
dependency issues, I will merge them immediately after the upcoming
merge window. Meanwhile please continue to sort out any outstanding
comments/concerns like the one you are discussing with Arnd.

regards,
Santosh

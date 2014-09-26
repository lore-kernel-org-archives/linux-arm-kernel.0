From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Fri, 26 Sep 2014 09:55:25 -0500
Subject: [PATCH v2 1/3] clocksource: arm_arch_timer: change clocksource
 name if CP15 unavailable
In-Reply-To: <54250FFE.2050605@linaro.org>
References: <1411052390-27238-1-git-send-email-nathan_lynch@mentor.com>
 <1411052390-27238-2-git-send-email-nathan_lynch@mentor.com>
 <54250FFE.2050605@linaro.org>
Message-ID: <54257E5D.5060600@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 09/26/2014 02:04 AM, Daniel Lezcano wrote:
> On 09/18/2014 04:59 PM, Nathan Lynch wrote:
>> The arm and arm64 VDSOs need CP15 access to the architected counter.
>> If this is unavailable (which is allowed by ARM v7), indicate this by
>> changing the clocksource name to "arch_mem_counter" before registering
>> the clocksource.
>>
>> Suggested by Stephen Boyd.
>>
>> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
>> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> Hi Nathan,
> 
> is it possible to have the acked-by of the different maintainers for the
> other patches ?

As Will said, he acked the series.

> Are these patches targeted to be merged for 3.18 ?

3.18 is preferable, if it's not too late.  But nothing will break if it
needs to wait.

Thanks,
Nathan

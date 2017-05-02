From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 2 May 2017 09:57:18 +0100
Subject: [PATCH 2/2] cpufreq: scpi: use new scpi_ops functions to remove
 duplicate code
In-Reply-To: <1644626.pZFp7GD5Yb@aspire.rjw.lan>
References: <1493371296-12465-1-git-send-email-sudeep.holla@arm.com>
 <1493371296-12465-2-git-send-email-sudeep.holla@arm.com>
 <20170428092456.GF21517@vireshk-i7> <1644626.pZFp7GD5Yb@aspire.rjw.lan>
Message-ID: <0587f9f7-0813-2348-3717-687ed1df3e0e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/04/17 22:34, Rafael J. Wysocki wrote:
> On Friday, April 28, 2017 02:54:56 PM Viresh Kumar wrote:
>> On 28-04-17, 10:21, Sudeep Holla wrote:
>>> scpi_ops now provide APIs to get the transition_latency and to add
>>> OPPs to the devices making those logic redundant here.
>>>
>>> This patch makes use of those APIs and removes the redunant code in
>>> this driver.
>>>
>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>> ---
>>>  drivers/cpufreq/scpi-cpufreq.c | 38 ++++++--------------------------------
>>>  1 file changed, 6 insertions(+), 32 deletions(-)
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
>>
> 
> OK
> 
> Sudeep, please route this through ARM.

Sure, thanks.

-- 
Regards,
Sudeep

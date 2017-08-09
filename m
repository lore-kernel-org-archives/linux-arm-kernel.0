From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 9 Aug 2017 11:17:51 +0100
Subject: [PATCH v2 18/18] cpufreq: scmi: add support for fast frequency
 switching
In-Reply-To: <20170809101301.GB29383@vireshk-i7>
References: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
 <1501857104-11279-19-git-send-email-sudeep.holla@arm.com>
 <20170809042825.GI28857@vireshk-i7>
 <0f89f543-39a9-30a5-4976-0c447f5fe843@arm.com>
 <20170809101301.GB29383@vireshk-i7>
Message-ID: <5bb13d54-f07b-6ca3-c77a-d7bebcdfc770@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/08/17 11:13, Viresh Kumar wrote:
> On 09-08-17, 11:09, Sudeep Holla wrote:
>> Firmware needs to serialize or override based on the timing of the two
>> consecutive requests.
> 
> Maybe add a comment over that routine and detail its working a bit? Like its not
> synchronous, etc. I expect that you would also add a callback with SCMI, so that
> the cpufreq driver is notified when frequency is changed ?
> 

OK, will do. Yes, I don't have firmware implementing notifications yet,
so waiting until I can test it.

-- 
Regards,
Sudeep

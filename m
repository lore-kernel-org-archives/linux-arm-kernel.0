From: gengdongjiu@huawei.com (gengdongjiu)
Date: Fri, 12 Jan 2018 15:51:00 +0800
Subject: [PATCH v4] perf tools: Add ARM Statistical Profiling Extensions
 (SPE) support
In-Reply-To: <0a07a10c-fc0c-3f97-ac01-59429aab0937@intel.com>
References: <20171121173302.bead17a1178ed4583e68014e@arm.com>
 <0a07a10c-fc0c-3f97-ac01-59429aab0937@intel.com>
Message-ID: <6ec89c5b-e978-bd2e-e350-df0c7c41ac33@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/1/11 22:17, Adrian Hunter wrote:
>>   (e.g., via 'perf inject --itrace'), are also not supported
>>
>> - technically both cs-etm and spe can be used simultaneously, however
>>   disabled for simplicity in this release
>>
>> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> For what is there now, it looks fine from the auxtrace point of view.  There
> are a couple of minor points below but nevertheless:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

This patch is good to me.
Reviewed-by: gengdongjiu at huawei.com

> 
>> ---
>> v4: rebased onto acme's perf/core, whitespace fixes.

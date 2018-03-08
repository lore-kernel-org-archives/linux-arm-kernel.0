From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 8 Mar 2018 12:14:49 +0000
Subject: [PATCH v3 10/22] arm64: capabilities: Allow features based on
 local CPU scope
In-Reply-To: <20180209182213.GH5862@e103592.cambridge.arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
 <20180209175513.17100-20-suzuki.poulose@arm.com>
 <20180209182213.GH5862@e103592.cambridge.arm.com>
Message-ID: <076d272e-d056-6316-7dff-2c123578f89a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/18 18:22, Dave Martin wrote:
> On Fri, Feb 09, 2018 at 05:54:49PM +0000, Suzuki K Poulose wrote:
>> So far we have treated the feature capabilities as system wide
>> and this doesn't help with features that could be detected on
> 
> doesn't -> wouldn't (since no such features exist yet)
> 
> detected to "detected locally" (maybe)
> 

Sure, fixed.

>> one or more CPUs (e.g, KPTI, Software prefetch). This patch
>> splits the feature detection to two phases :
>>
>>   1) Local CPU features are checked on all boot time active CPUs.
>>   2) System wide features are checked only once after all CPUs are
>>      active.
>>
>> Cc: Dave Martin <dave.martin@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Otherwise,
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> 

Thanks,

Suzuki

From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 17 Jan 2017 14:07:39 +0000
Subject: [PATCH v4 3/4] arm64: dts: juno: add CoreSight support for Juno
 r1/r2 variants
In-Reply-To: <d89b805b-cc6f-37d5-2b64-4f83fa086db6@arm.com>
References: <1484655313-9025-1-git-send-email-sudeep.holla@arm.com>
 <1484655313-9025-4-git-send-email-sudeep.holla@arm.com>
 <d89b805b-cc6f-37d5-2b64-4f83fa086db6@arm.com>
Message-ID: <a336df07-3e7c-c977-f7b3-22a90a728a2c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/01/17 13:27, Suzuki K Poulose wrote:
> On 17/01/17 12:15, Sudeep Holla wrote:
>> From: Mike Leach <mike.leach@linaro.org>
>>
>> The CoreSight support added for Juno is valid for only Juno r0.
>> The Juno r1 and r2 variants have additional components and alternative
>> connection routes between trace source and sinks.
>>
>> This patch builds on top of the existing r0 support and extends it to
>> Juno r1/r2 variants.
>>
>> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Mike Leach <mike.leach@linaro.org>
>> [sudeep.holla at arm.com: minor changelog update and major reorganisation of
>>     the common coresight components back into juno-base.dtsi to avoid
>>     duplication, also renamed funnel node names]
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi | 100
>> ++++++++++++++++++++++++++++++
>>  arch/arm64/boot/dts/arm/juno-r1.dts       |   9 +++
>>  arch/arm64/boot/dts/arm/juno-r2.dts       |   9 +++
>>  3 files changed, 118 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
>> b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
>> new file mode 100644
>> index 000000000000..563463ed28c7
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
>> @@ -0,0 +1,100 @@
>> +/ {
>> +    funnel at 20130000 { /* cssys2 */
> 
> Typo, that should be csys1. Rest looks good to me.
> 

Fixed locally.

> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks again.

-- 
Regards,
Sudeep

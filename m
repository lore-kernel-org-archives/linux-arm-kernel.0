From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 1 Jun 2016 09:19:19 -0400
Subject: [PATCH] ARM: dts: exynos: Add TMU nodes regulator supply for
 Peach boards
In-Reply-To: <574EA1D1.6020606@samsung.com>
References: <1464731280-24588-1-git-send-email-javier@osg.samsung.com>
 <574EA1D1.6020606@samsung.com>
Message-ID: <4ed20897-8409-404f-ce6a-73ce6affeb7e@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 06/01/2016 04:50 AM, Krzysztof Kozlowski wrote:
> On 05/31/2016 11:48 PM, Javier Martinez Canillas wrote:

[snip]

>>  
>> +&tmu_cpu0 {
>> +	vtmu-supply = <&ldo10_reg>;
>> +};
>> +
>> +&tmu_cpu1 {
>> +	vtmu-supply = <&ldo10_reg>;
>> +};
>> +
>> +&tmu_cpu2 {
>> +	vtmu-supply = <&ldo10_reg>;
>> +};
>> +
>> +&tmu_cpu3 {
>> +	vtmu-supply = <&ldo10_reg>;
>> +};
>> +
>> +&tmu_gpu {
>> +	vtmu-supply = <&ldo10_reg>;
>> +};
>> +
> 
> Here and for Peach Pi please put the nodes in alphabetical order.
>

Right, sorry. I completely forgot about keeping the order.
 
> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

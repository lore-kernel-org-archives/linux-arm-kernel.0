From: antoine.tenart@free-electrons.com (=?UTF-8?B?QW50b2luZSBUw6luYXJ0?=)
Date: Thu, 03 Apr 2014 10:54:07 +0200
Subject: [PATCH 2/3] ARM: dts: document the berlin enable-method property
In-Reply-To: <20140403162202.79b63729@xhacker>
References: <1396512496-8030-1-git-send-email-antoine.tenart@free-electrons.com>	<1396512496-8030-3-git-send-email-antoine.tenart@free-electrons.com>
 <20140403162202.79b63729@xhacker>
Message-ID: <533D21AF.2070508@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jisheng,

On 03/04/2014 10:22, Jisheng Zhang wrote:
> Hi,
>
> On Thu, 3 Apr 2014 01:08:15 -0700
> Antoine T?nart <antoine.tenart@free-electrons.com> wrote:
>
>> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
>> ---
>>   Documentation/devicetree/bindings/arm/cpus.txt | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt
>> b/Documentation/devicetree/bindings/arm/cpus.txt index
>> 333f4aea3029..a9e42a2dbc99 100644 ---
>> a/Documentation/devicetree/bindings/arm/cpus.txt +++
>> b/Documentation/devicetree/bindings/arm/cpus.txt @@ -185,6 +185,8 @@ nodes
>> to be present and contain the properties described below. "qcom,gcc-msm8660"
>>   			    "qcom,kpss-acc-v1"
>>   			    "qcom,kpss-acc-v2"
>> +			    "marvell,88de31-smp" - cpu-core handling for
>
> why not "marvell,berlin-smp"?

We have SMP on the BG2 and the BG2Q currently. Future boards may not be 
compatible with this method (BG3 ?), I think "marvell,berlin-smp" is too 
generic.

We could use "marvell,88de31xx-smp" as Alexandre suggested.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

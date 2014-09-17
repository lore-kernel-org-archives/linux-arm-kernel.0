From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 17 Sep 2014 12:03:37 -0700
Subject: [PATCH] ARM: DT: ifc6410: Add board memory range.
In-Reply-To: <54192B64.6070604@smartplayin.com>
References: <1410932179-4652-1-git-send-email-srinivas.kandagatla@linaro.org>
 <54192B64.6070604@smartplayin.com>
Message-ID: <FA9D8682-DB0E-48CF-A519-86A0465300E1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 16, 2014, at 11:34 PM, Pramod Gurav <pramod.gurav@smartplayin.com> wrote:

> Hi Srini,
> 
> Thanks for the patch.
> Tested-by: Pramod Gurav <pramod.gurav@smartplayin.com>
> 
> A minor nit.
> On Wednesday 17 September 2014 11:06 AM, Srinivas Kandagatla wrote:
>> This patch adds memory details of IFC6410 as this is necessary to
>> fix the in-correct memory start comming from ATAGs.
>> 
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>> arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 5 +++++
>> 1 file changed, 5 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
>> index 90db8af..3287f12 100644
>> --- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
>> +++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
>> @@ -4,6 +4,11 @@
>> 	model = "Qualcomm APQ8064/IFC6410";
>> 	compatible = "qcom,apq8064-ifc6410", "qcom,apq8064";
>> 
>> +	memory{
> Space before {?
>> +		device_type = "memory";
>> +		reg = <0x80000000 0x80000000>;
>> +	};
>> +
>> 	soc {
>> 		gsbi at 16600000 {
>> 			status = "ok?;

Hmm, this doesn?t seem to work for me.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

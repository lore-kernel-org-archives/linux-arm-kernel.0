From: sricharan@codeaurora.org (sricharan at codeaurora.org)
Date: Tue, 17 Mar 2015 13:10:32 -0000
Subject: [PATCH 5/6] dts: msm8974: Add blsp2_bam dma node
In-Reply-To: <550822A7.1010209@mm-sol.com>
References: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
 <1426268992-19298-6-git-send-email-sricharan@codeaurora.org>
 <550822A7.1010209@mm-sol.com>
Message-ID: <c65027aa3f228387475c5284a9d377dc.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On 03/13/2015 07:49 PM, Sricharan R wrote:
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm/boot/dts/qcom-msm8974.dtsi | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi
>> b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> index e265ec1..3f648ae 100644
>> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
>> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> @@ -247,5 +247,15 @@
>>  			#address-cells = <1>;
>>  			#size-cells = <0>;
>>  		};
>> +
>> +		blsp2_dma: dma at f9944000 {
>> +			compatible = "qcom,bam-v1.4.0";
>> +			reg = <0xf9944000 0x19000>;
>> +			interrupts = <0 239 0>;
>
> for completeness this should be:
>
> interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
>
Ok, will fix. Thanks

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

From: sricharan@codeaurora.org (sricharan at codeaurora.org)
Date: Mon, 16 Mar 2015 09:55:26 -0000
Subject: [PATCH 6/6] dts: msm8974: Add dma channels for blsp2_i2c1 node
In-Reply-To: <20150313195425.GA16977@qualcomm.com>
References: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
 <1426268992-19298-7-git-send-email-sricharan@codeaurora.org>
 <20150313195425.GA16977@qualcomm.com>
Message-ID: <0ac0be987e1d6b8bdfd524f14c83fcb4.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On Fri, Mar 13, 2015 at 11:19:52PM +0530, Sricharan R wrote:
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>
> Reviewed-by: Andy Gross <agross@codeaurora.org>
>
>>  arch/arm/boot/dts/qcom-msm8974.dtsi | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi
>> b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> index 3f648ae..1ec7ec5 100644
>> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
>> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> @@ -246,6 +246,8 @@
>>  			clock-names = "core", "iface";
>>  			#address-cells = <1>;
>>  			#size-cells = <0>;
>> +			dmas = <&blsp2_dma 20>, <&blsp2_dma 21>;
>> +			dma-names = "bam-tx", "bam-rx";
>
> more of a nit, but the bam- is unnecessary.  it's just rx/tx.

  Ok, will change it.

Regards,
 Sricharan

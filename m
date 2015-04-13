From: sricharan@codeaurora.org (Sricharan R)
Date: Mon, 13 Apr 2015 09:44:36 +0530
Subject: [PATCH V3 5/6] dts: msm8974: Add blsp2_bam dma node
In-Reply-To: <55299C4A.3020905@cogentembedded.com>
References: <1428736145-18361-1-git-send-email-sricharan@codeaurora.org>
 <1428736145-18361-6-git-send-email-sricharan@codeaurora.org>
 <55299C4A.3020905@cogentembedded.com>
Message-ID: <552B42AC.7010407@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/12/2015 03:42 AM, Sergei Shtylyov wrote:
> Hello.
>
> On 04/11/2015 10:09 AM, Sricharan R wrote:
>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>   arch/arm/boot/dts/qcom-msm8974.dtsi | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>
>> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi
>> b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> index e265ec1..2c26151 100644
>> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
>> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> [...]
>> @@ -247,5 +247,15 @@
>>               #address-cells = <1>;
>>               #size-cells = <0>;
>>           };
>> +
>> +        blsp2_dma: dma at f9944000 {
>
>     The ePAPR standard says that the node name should be
> "dma-controller", not just "dma".
>
  Ok, will correct this.

Regards,
  Sricharan

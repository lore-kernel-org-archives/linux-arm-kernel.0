From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Fri, 23 May 2014 17:17:45 +0300
Subject: [PATCH v1 5/5] ARM: dts: qcom: Add APQ8084 serial port DT node
In-Reply-To: <693A0E52-34CF-4A63-A8D0-A83780F969F0@codeaurora.org>
References: <1400775885-10296-1-git-send-email-gdjakov@mm-sol.com>
 <1400775885-10296-6-git-send-email-gdjakov@mm-sol.com>
 <693A0E52-34CF-4A63-A8D0-A83780F969F0@codeaurora.org>
Message-ID: <537F5889.5080902@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2014 07:32 PM, Kumar Gala wrote:
>
> On May 22, 2014, at 11:24 AM, Georgi Djakov <gdjakov@mm-sol.com> wrote:
>
>> Add the necessary DT node to probe the serial driver on
>> APQ8084 platforms.
>>
>> Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
>> ---
>> arch/arm/boot/dts/qcom-apq8084.dtsi |    7 +++++++
>> 1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
>> index 2dcd11e..c346549 100644
>> --- a/arch/arm/boot/dts/qcom-apq8084.dtsi
>> +++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
>> @@ -185,5 +185,12 @@
>> 			reg = <0xfc400000 0x4000>;
>> 		};
>>
>> +		serial at f995e000 {
>
> Mark it disabled in the soc.dtsi and ?ok? in the board.
>

Oh, of course!

Thanks,
Georgi

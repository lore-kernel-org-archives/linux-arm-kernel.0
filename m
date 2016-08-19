From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez-Ortiz)
Date: Fri, 19 Aug 2016 11:30:13 +0200
Subject: [PATCH 2/2] arm64: dts: set UART1 clock frequency to 150MHz
In-Reply-To: <57B6C35B.5010901@hisilicon.com>
References: <1467965467-28180-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1467965467-28180-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <57836C8B.6020509@hisilicon.com>
 <85888839-f776-9f8a-0f06-8a1f69aab56d@linaro.org>
 <57B6C35B.5010901@hisilicon.com>
Message-ID: <35917dd4-f559-cd28-5671-506fc7e8397f@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2016 10:29 AM, Wei Xu wrote:
>
> On 19/08/2016 07:57, Jorge Ramirez wrote:
>> On 07/11/2016 11:53 AM, Wei Xu wrote:
>>> Hi Jorge,
>>>
>>> On 08/07/2016 09:11, Jorge Ramirez-Ortiz wrote:
>>>> Enable support for higher baud rates (up to 3Mbps) in UART1 - required
>>>> for bluetooth transfers.
>>>>
>>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>>>> Tested-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>>> Fine to me.
>>> Thanks!
>>>
>>> Acked-by: Wei Xu <xuwei5@hisilicon.com>
>>>
>>> Best Regards,
>>> Wei
>>>
>>>> ---
>>>>    arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
>>>> index e92a30c..27be812 100644
>>>> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
>>>> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
>>>> @@ -55,6 +55,8 @@
>>>>            };
>>>>              uart1: uart at f7111000 {
>>>> +            assigned-clocks = <&sys_ctrl HI6220_UART1_SRC>;
>>>> +            assigned-clock-rates = <150000000>;
>>>>                status = "ok";
>>>>            };
>>>>   
> Hi Jorge,
>
>> Wei Xu,
>>
>> I couldn't find the change upstream. has it been merged?
> No.
> I thought Mike will pick them.
> If nothing need to be change, I will pick up it.

yes please, AFAIK nothing needs to be changed.

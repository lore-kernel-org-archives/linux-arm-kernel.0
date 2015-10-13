From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 13 Oct 2015 09:14:38 +0900
Subject: [PATCH 3/3] ARM: dts: exynos5422-odroidxu3: Added UHS-I bus speed
 support
In-Reply-To: <CANAwSgSLFviT4ZNXTYwxYs2pbrr9ozJmPMauhgRPO0556Rsr_g@mail.gmail.com>
References: <1444578364-1384-1-git-send-email-linux.amoon@gmail.com>
 <1444578364-1384-3-git-send-email-linux.amoon@gmail.com>
 <561B48B7.1040201@samsung.com>
 <CANAwSgSLFviT4ZNXTYwxYs2pbrr9ozJmPMauhgRPO0556Rsr_g@mail.gmail.com>
Message-ID: <561C4CEE.3050905@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.10.2015 00:32, Anand Moon wrote:
> Hi Krzysztof,
> 
> On 12 October 2015 at 11:14, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>> On 12.10.2015 00:46, Anand Moon wrote:
>>> Added support for UHS-I bus speed 50MB/s (SDR50, DDR50) 104MB/s (SDR104)
>>
>> This description is not entirely correct. The MMC driver already
>> supports these UHS speeds (you did not any code) so you rather enabled
>> it (description of bindings says "is supported").
>>
>> You mentioned DDR50 but I don't see respective property below.
>>
>> How do you know that these modes are really supported? I don't know. Can
>> you convince me?
> 
> Setting this DDR50 capability give me this error. That's the reason to
> drop this capability.

But you mentioned it in commit message! "Added support for UHS-I ...
(DDR50)"

In the same time dropping DDR50 is not an sufficient proof that "SDR50
and SDR104 are really supported".

Best regards,
Krzysztof

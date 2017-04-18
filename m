From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Tue, 18 Apr 2017 17:27:39 +0900
Subject: [PATCH v2 3/3] arm64: dts: exynos: Add support for s6e3hf2
 panel device on TM2e board
In-Reply-To: <94152d85-5fb0-f5dc-045d-e6ee6c009f42@samsung.com>
References: <1492408934-22096-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170417060220epcas5p42f6ed43d9db94779382e84a129b9da2d@epcas5p4.samsung.com>
 <1492408934-22096-4-git-send-email-hoegeun.kwon@samsung.com>
 <b9bfcdd9-5576-34c3-6c7d-556b6c81946d@samsung.com>
 <f2acb724-ba41-175c-061a-7be765cc1939@samsung.com>
 <94152d85-5fb0-f5dc-045d-e6ee6c009f42@samsung.com>
Message-ID: <fe6129d5-2501-5685-c11f-aa910b39c10e@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2017 04:56 PM, Andrzej Hajda wrote:
> On 18.04.2017 09:44, Hoegeun Kwon wrote:
>> On 04/18/2017 03:00 PM, Andrzej Hajda wrote:
>>> On 17.04.2017 08:02, Hoegeun Kwon wrote:
>>>> This patch add the panel device tree node for s6e3hf2 display
>>>> controller to TM2e dts.
>>>>
>>>> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
>>> Maybe it would be good to remove te-gpios property - tm2/tm2e uses
>>> hardware trigger, so it is not necessary and generates useless interrupts.
>> Thanks for your review.
>>
>> I agree, but I thinks remove the te-gpio property after your patch [1]
>> has been merged.
> Patch [1] has been merged about month ago :)

Ah..., My mistake.... :)

I will send ver3 patchset without te-gpio property.

Best regards,
Hoegeun

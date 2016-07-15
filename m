From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Fri, 15 Jul 2016 11:37:40 +0200
Subject: [PATCH] media: Doc add missing documentation for
 samsung,exynos4212-jpeg
In-Reply-To: <5788AD39.1010108@samsung.com>
References: <1468526499-8840-1-git-send-email-shuahkh@osg.samsung.com>
 <578890BA.8040101@samsung.com> <57889B73.4090607@samsung.com>
 <57889C23.3050106@samsung.com> <57889EAB.30502@samsung.com>
 <57889FD5.9070302@samsung.com> <5788AA5E.3070301@samsung.com>
 <5788AD39.1010108@samsung.com>
Message-ID: <5788AEE4.8080606@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2016 11:30 AM, Krzysztof Kozlowski wrote:
> On 07/15/2016 11:18 AM, Jacek Anaszewski wrote:
>> On 07/15/2016 10:33 AM, Krzysztof Kozlowski wrote:
>>> On 07/15/2016 10:28 AM, Jacek Anaszewski wrote:
>>>> On 07/15/2016 10:17 AM, Krzysztof Kozlowski wrote:
>>>>> On 07/15/2016 10:14 AM, Jacek Anaszewski wrote:
>>>>>>> However if these compatibles are exactly equal then
>>>>>>> only one should be preferred. It makes everything easier. Second
>>>>>>> can be
>>>>>>> still documented e.g. as deprecated.
>>>>>>
>>>>>> Still, both of them are present in the driver. Shouldn't it be
>>>>>> reflected
>>>>>> in the documentation?
>>>>>
>>>>> Right, it is a good practice, so how about:
>>>>>
>>>>>      - compatible    : should be one of:
>>>>>              "samsung,s5pv210-jpeg", "samsung,exynos3250-jpeg",
>>>>>              "samsung,exynos4210-jpeg", "samsung,exynos5420-jpeg",
>>>>>              "samsung,exynos5433-jpeg";
>>>>>
>>>>>              Deprecated: "samsung,exynos4212-jpeg"
>>>>>
>>>>> (or any other formatting)
>>>>> plus update to DTS changing it to 4210?
>>>>
>>>> Why newer 4212 version should be made deprecated?
>>>
>>> I don't mind the other way. However it seems logical to me that newer
>>> chip is compatible with existing one so the existing one (older) is
>>> used. When adding support for new devices, for most of re-usable drivers
>>> we use old compatibles. But as I said, it doesn't really matter to me.
>>
>> Frankly speaking marking a compatible deprecated looks weird to me.
>> It can be interpreted in the way that the device itself is deprecated
>> or it is not fully reliable.
>
> Marking a compatible or a property deprecated is commonly used, if
> needed of course. It has nothing to do with device being deprecated.
> This is documentation for bindings and deprecation affects only
> bindings. It is not weird or something strange. We already did this for
> some of Exynos compatibles (later removing them) and there are quite
> many examples in Documentation already.

If this is broadly accepted pattern, then I will not argue against.
Let's proceed as you proposed.

-- 
Best regards,
Jacek Anaszewski

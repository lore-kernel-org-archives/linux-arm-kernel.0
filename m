From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Fri, 15 Jul 2016 16:09:26 -0600
Subject: [PATCH] media: Doc add missing documentation for
 samsung,exynos4212-jpeg
In-Reply-To: <5788AEE4.8080606@samsung.com>
References: <1468526499-8840-1-git-send-email-shuahkh@osg.samsung.com>
 <578890BA.8040101@samsung.com> <57889B73.4090607@samsung.com>
 <57889C23.3050106@samsung.com> <57889EAB.30502@samsung.com>
 <57889FD5.9070302@samsung.com> <5788AA5E.3070301@samsung.com>
 <5788AD39.1010108@samsung.com> <5788AEE4.8080606@samsung.com>
Message-ID: <57895F16.7010101@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof and Jacek,

Thanks for the review.

On 07/15/2016 03:37 AM, Jacek Anaszewski wrote:
> On 07/15/2016 11:30 AM, Krzysztof Kozlowski wrote:
>> On 07/15/2016 11:18 AM, Jacek Anaszewski wrote:
>>> On 07/15/2016 10:33 AM, Krzysztof Kozlowski wrote:
>>>> On 07/15/2016 10:28 AM, Jacek Anaszewski wrote:
>>>>> On 07/15/2016 10:17 AM, Krzysztof Kozlowski wrote:
>>>>>> On 07/15/2016 10:14 AM, Jacek Anaszewski wrote:
>>>>>>>> However if these compatibles are exactly equal then
>>>>>>>> only one should be preferred. It makes everything easier. Second
>>>>>>>> can be
>>>>>>>> still documented e.g. as deprecated.
>>>>>>>
>>>>>>> Still, both of them are present in the driver. Shouldn't it be
>>>>>>> reflected
>>>>>>> in the documentation?
>>>>>>
>>>>>> Right, it is a good practice, so how about:
>>>>>>
>>>>>>      - compatible    : should be one of:
>>>>>>              "samsung,s5pv210-jpeg", "samsung,exynos3250-jpeg",
>>>>>>              "samsung,exynos4210-jpeg", "samsung,exynos5420-jpeg",
>>>>>>              "samsung,exynos5433-jpeg";
>>>>>>
>>>>>>              Deprecated: "samsung,exynos4212-jpeg"
>>>>>>
>>>>>> (or any other formatting)
>>>>>> plus update to DTS changing it to 4210?

I am sending the v2 doc patch that adds samsung,exynos4212-jpeg as
deprecated to begin with.

thanks,
-- Shuah

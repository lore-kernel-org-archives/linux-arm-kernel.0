From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 25 Aug 2015 16:19:18 +0530
Subject: [PATCH-v2 1/5] mfd: 88pm800: Fix tabbing issue
In-Reply-To: <20150825103019.GP19409@x1>
References: <1440442594-3102-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440442594-3102-2-git-send-email-vaibhav.hiremath@linaro.org>
 <20150825075121.GE19409@x1> <55DC2A51.6090008@linaro.org>
 <20150825103019.GP19409@x1>
Message-ID: <55DC482E.8030206@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 25 August 2015 04:00 PM, Lee Jones wrote:
> On Tue, 25 Aug 2015, Vaibhav Hiremath wrote:
>> On Tuesday 25 August 2015 01:21 PM, Lee Jones wrote:
>>> On Tue, 25 Aug 2015, Vaibhav Hiremath wrote:
>>>
>>>> Driver had coding style issues where spaces were used instead
>>>> of tabs. This patch fixes them all.
>>>
>>> That's not all it's doing though is it?
>>>
>>
>> Yes, its just tabbing related fixes.
>
> No, it's really not.
>
>>> Please describe all of your changes.
>
> ... we're also taking the opportunity to remove the unnecessary
> protection surrounding some of the defined values.
>

Ohhh ok. Forgot about brackets :)

Anyway,
Based on the comments you provided, I think both header file and
source file needs some more cleanup.
I will try to incorporate all changes in next version.

I may also submit separate series for cleanup version (depends on
patches I produce).

Thanks,
Vaibhav

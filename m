From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 16 May 2014 06:11:24 +0900
Subject: [GIT PULL 1/4] Samsung clock Exynos5260 support for v3.16
In-Reply-To: <5373EB24.8000306@gmail.com>
References: <1400090591-5064-1-git-send-email-t.figa@samsung.com>
 <5373CB1A.1040801@samsung.com> <20140514201313.19795.35617@quantum>
 <5373CFFE.1000209@gmail.com> <20140514220744.19795.64527@quantum>
 <5373EB24.8000306@gmail.com>
Message-ID: <53752D7C.4010003@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/14 07:16, Tomasz Figa wrote:
> On 15.05.2014 00:07, Mike Turquette wrote:
>> Quoting Tomasz Figa (2014-05-14 13:20:14)
>>> Hi Mike,
>>>
>>> On 14.05.2014 22:13, Mike Turquette wrote:
>>>> Quoting Kukjin Kim (2014-05-14 12:59:22)
>>>>> On 05/15/14 03:03, Tomasz Figa wrote:
>>>>>
>>>>> Hi Mike,
>>>>>
>>>>> I've talked to Tomasz about current samsung related clock stuff. Since
>>>>> they are mostly having dependency on samsung tree now not clock core
>>>>> stuff, so would be better if it could be sent to upstream via samsung
>>>>> tree. And as you know, updating arch/arm/ and clock stuff are usually
>>>>> required for adding new SoC or supporting CCF newly...
>>>>
>>>> The Samsung clk pull requests only touch two arch/arm Kconfig files and
>>>> one dtsi file. That's not a lot of arch/arm churn. Is there a strong
>>>> reason that this needs to go through the samsung/arm-soc trees?
>>>> Otherwise it should continue to go through the clk tree.
>>>
>>> Obviously they are patches for Samsung clock drivers. ;)
>>>
>>> The issue here is that there is a number of patches already merged in
>>> Samsung tree on which the patches discussed here depend.
>>
>> OK, I think I misread the original email. I thought you were asking for
>> future pull requests to go through the samsung tree, but you only mean
>> the ones in this thread. No problem there.
>>
>> Acked-by: Mike Turquette<mturquette@linaro.org>
>
Mike, thanks for your ack on this whole pull-requests.

I will pull 1 to 4 into samsung tree for 3.16.

> Thanks.
>
> As you probably noticed with my pull request for 3.15, we've been
> getting quite a lot of burden due to dependencies between arch and clk
> patches lastly, but this is inevitable when we are moving things out of
> arch.
>
> The good news is that after patches from this pull request series, we
> will end up with just one, more or less active platform (s5pv210) that
> needs to be converted (and work already in progress).
>
Sounds great.

Thanks,
Kukjin

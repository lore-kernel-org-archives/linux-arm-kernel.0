From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 1 May 2014 16:40:54 +0530
Subject: [PATCH 1/1] clk: exynos-5420: Fix VPLL lock offset
In-Reply-To: <CAK9yfHyVVjfip2p6gDM8ghJ301NH9kTtVK1La53WPFfxxLD9nQ@mail.gmail.com>
References: <1394681222-27882-1-git-send-email-sachin.kamat@linaro.org>
 <53219C1C.1030501@samsung.com>
 <CAK9yfHyVVjfip2p6gDM8ghJ301NH9kTtVK1La53WPFfxxLD9nQ@mail.gmail.com>
Message-ID: <CAK9yfHxg4CbfrpwwqO=xzCDeeoSWVXu4CU4haZEhvj1YszRCTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 13 March 2014 20:27, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> On 13 March 2014 17:23, Tomasz Figa <t.figa@samsung.com> wrote:
>> Hi Sachin,
>>
>>
>> On 13.03.2014 04:27, Sachin Kamat wrote:
>>>
>>> Set it as per the user manual.
>>>
>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>> ---
>
>>
>> Looks fine. Will queue for 3.15, since ATM there is no support for PLL rate
>> setting on Exynos 5420 (no rate tables registered).
>
> Yes, that is correct. Thanks Tomasz.

Looks like this patch hasn't made it to mainline yet.

-- 
With warm regards,
Sachin

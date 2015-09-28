From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 28 Sep 2015 18:17:36 +0900
Subject: [PATCH RESEND] ARM: dts: Move display-timings node from fimd to dp
In-Reply-To: <CAAObsKDqpBnggX7sHCgQ5d7ZxYumh_ga8kbLQc4bQ=N+M6BoCg@mail.gmail.com>
References: <1442494120-463-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAAObsKDqpBnggX7sHCgQ5d7ZxYumh_ga8kbLQc4bQ=N+M6BoCg@mail.gmail.com>
Message-ID: <560905B0.1090708@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 28.09.2015 o 17:56, Tomeu Vizoso pisze:
> Hi Kukjin and Krzysztof,
> 
> could you take a look at this?

Of course, but please be patient. It waits on my todo list. I have just
returned from holidays.

Best regards,
Krzysztof

> 
> Thanks,
> 
> Tomeu
> 
> On 17 September 2015 at 14:48, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>> From: Sean Paul <seanpaul@chromium.org>
>>
>> This patch moves the display-timings node from fimd to dp to reflect the
>> device tree bindings change.
>>
>> Signed-off-by: Sean Paul <seanpaul@chromium.org>
>> [tomeu.vizoso at collabora.com: Rebased]
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>
>> ---
>>
>> Hi,
>>
>> looks like a long time ago the bindings were changed and the DTs for
>> these boards weren't updated.
>>
>> I have retaken Sean's forgotten patch and rebased it, but I have only
>> tested on an Arndale that exynos-drm doesn't complain about missing
>> timings.
>>
>> Regards,
>>

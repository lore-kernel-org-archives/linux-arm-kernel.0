From: xuwei5@hisilicon.com (Wei Xu)
Date: Mon, 4 Sep 2017 10:21:00 +0100
Subject: [PATCH 2/2] arm64: dts: hi6220: enable watchdog
In-Reply-To: <20170901202816.GZ21656@codeaurora.org>
References: <1503993518-24428-1-git-send-email-leo.yan@linaro.org>
 <1503993518-24428-2-git-send-email-leo.yan@linaro.org>
 <20170901013233.GL21656@codeaurora.org> <59A937E7.2060303@hisilicon.com>
 <20170901202816.GZ21656@codeaurora.org>
Message-ID: <59AD1AFC.8060600@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 2017/9/1 21:28, Stephen Boyd wrote:
> On 09/01, Wei Xu wrote:
>> Hi Stephen,
>>
>> On 2017/9/1 2:32, Stephen Boyd wrote:
>>> On 08/29, Leo Yan wrote:
>>>> From: Dmitry Shmidt <dimitrysh@google.com>
>>>>
>>>> This patch is to add watchdog binding for Hi6220 on Hikey board.
>>>>
>>>> Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
>>>> ---
>>>
>>> This will go through arm-soc?
>>>
>>
>> Can you pick up it for v4.14?
>> Otherwise I am fine to pick up it and queue for v4.15.
> 
> Sounds like it will go for v4.15. Otherwise, you can send it to
> arm-soc with the raw number instead of #define number and then
> fix it up to use the #define later.
> 

I did not get your meaning.
Do you mean the "HI6220_WDT0/1/2_PCLK" in the patch 1 that
we need to replace with raw number?
They are already in the mainline.

Best Regards,
Wei

From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 17 Oct 2015 19:08:28 +0900
Subject: [PATCH v2 1/2] clk: samsung: exynos5250: Add DISP1 clocks
In-Reply-To: <56221B26.2050407@osg.samsung.com>
References: <1444905084-22540-1-git-send-email-tomeu.vizoso@collabora.com>
 <1444905084-22540-2-git-send-email-tomeu.vizoso@collabora.com>
 <56203AD3.2050905@samsung.com> <20151016124935.20687.4394@quantum>
 <20151016172651.GB23912@codeaurora.org>
 <CAAObsKAjZX8XxTAFVKq4BCSZSrKG5xQPTue+z+xnJDD8QwK88Q@mail.gmail.com>
 <56218B2D.9040007@kernel.org>
 <CAJKOXPf5Dnh36rrY6Vet13EHKB3gJuU0VnAfsyYnvWTx92O_GA@mail.gmail.com>
 <56221B26.2050407@osg.samsung.com>
Message-ID: <CAJKOXPdvGUbkPB4E5uufQ=a63k7FK7puJjgY7xWnyqjGVhrnGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-10-17 18:55 GMT+09:00 Javier Martinez Canillas <javier@osg.samsung.com>:
> Hello Krzysztof,
>
> On 10/17/2015 10:53 AM, Krzysztof Kozlowski wrote:
>> 2015-10-17 8:41 GMT+09:00 Kukjin Kim <kgene@kernel.org>:
>
> [snip]
>
>>>>
>>> So...how can I take 2nd patch of this series in samsung(arm-soc) tree?
>>> And this series shouldn't be for fixes for 4.3?...Mike how do you think?
>>
>> Stephen acked it so I thought everything will go through samsung-soc.
>>
>> Dear Kukjin,
>> Indeed this can go as fix for current cycle... but in the same time
>> this does not fix any specific regression. Tomeu did not describe when
>> issue happened for the first time so I assumed it was like that
>> always. It's up to you.
>>
>
> Sorry for not answering about this series before but I've been in contact
> with Tomeu over IRC before he posted it and since you already added your
> Reviewed-by tag, I didn't feel the need do to it.
>
> This is a regression for 4.3 since S2R was working correctly for 4.2 in
> Snow, I tested after fixing resume with commit 6fd4899a54a5 ("irqchip:
> exynos-combiner: Save IRQ enable set on suspend") and the display was
> always enabled on resume.

Hmmm, that means the patchset indeed should go as fixes.

Thanks for details,
Krzysztof

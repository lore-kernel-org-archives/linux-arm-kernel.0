From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 29 Oct 2015 19:29:40 +0900
Subject: [PATCH v3 1/4] Documentation: dt-bindings: Describe SROMc
 configuration
In-Reply-To: <008001d1121d$c0fef160$42fcd420$@samsung.com>
References: <cover.1446018918.git.p.fedin@samsung.com>
 <046d990092dc85cf50db9082fc894d93a3ece7c0.1446018918.git.p.fedin@samsung.com>
 <563183F9.6020806@samsung.com>
 <008001d1121d$c0fef160$42fcd420$@samsung.com>
Message-ID: <CAJKOXPcSehXRYDpYiybzdagPS76QKGpeMb7DxkpwJq8GTfuPOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-10-29 16:45 GMT+09:00 Pavel Fedin <p.fedin@samsung.com>:
>  Hello!
>
>> You missed here a lot of potential Cc. Please use get_maintainer.pl
>> script. It *must* be sent to devicetree list.
>>
>> Please send it also to DeviceTree maintainers because you are adding
>> quite generic names for bindings so they may have interesting thoughts
>> on this.
>>
>> LKML list is also missing.
>
>  Ok. Next version will go there too.
>
>> Any vendor prefix here? How generic is this?
>
>  I just don't know... Does *everything* really need a vendor prefix? How readable would that be? "compatible" property already says
> that it's samsung-exynos-specific. And IMHO it's quite obvious that properties of vendor-specific device are automatically
> vendor-specific.
>  Ok, i am currently fixing up the rest and will post v4 soon, and will Cc: it to devicetree ML.

Which my reply you are referring to? You stripped part of some
sentence and put it without *any context*. Just random sentence.
I asked for vendor prefix in few places... srom-timing? width? And I
do not remember where I used exactly these words. This is why
*context* is needed.

>
>  P.S. I intentionally omit the rest of the text in order to avoid overquoting, since we are already focused on some specific things.
> If someone wants to get the whole picture, he/she could just browse back to the start of the thread. Or is it considered wrong
> approach in this particular ML?

Yep, selecting some sentences and replying only to them, leaving the
context away, is highly confusing. I reply in different places,
sometimes asking for similar things. Removing context messes this up.
In the same time all of my other questions are being removed without
any acknowledgment so I do not know if they were ignored or just
silently acked.

I show you example:

>  I just don't know...
I don't know neither.

> If someone wants to get the whole picture, he/she could just browse back to the start of the thread.
Yes, I would just scroll up and see the context. No, wait. There is no
context. I have to find mine original email and compare which part was
ignored, which was applied and which quoted sentence you are referring
to.

Best regards,
Krzysztof

From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 18 Dec 2015 23:19:58 +0100
Subject: [PATCH] mmc: pwrseq_simple: Fix regression with optional GPIOs
In-Reply-To: <20151218161406.GL23396@atomide.com>
References: <1449528845-25189-1-git-send-email-tony@atomide.com>
 <CAPDyKFpxiOJJdh-nLXjxv3DYJnW3RAf_9aqMfds46=-oqPd5ng@mail.gmail.com>
 <20151218161406.GL23396@atomide.com>
Message-ID: <CAPDyKFr8e6wDxkGwnOwijQiOgF7oq6gCoHmqbubv6oSbpYbwqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 December 2015 at 17:14, Tony Lindgren <tony@atomide.com> wrote:
> * Ulf Hansson <ulf.hansson@linaro.org> [151207 16:20]:
>> +Linus
>>
>> On 7 December 2015 at 23:54, Tony Lindgren <tony@atomide.com> wrote:
>> > Commit ce037275861e ("mmc: pwrseq_simple: use GPIO descriptors array API")
>> > changed the handling MMC power sequence so GPIOs no longer are optional.
>> >
>> > This broke SDIO WLAN at least for omap5 that can't yet use the reset GPIOs
>> > with pwrseq_simple as a wait is needed after enabling the SDIO device.
>>
>> Can you elaborate on this. Did it break omap5 or not? :-)
>
> Ulf, is this patch queued for v4.4 as a regression fix? I don't see it
> in Linux next or mainline trees?

Ohh, I guess there where some misunderstanding. I made a bunch of
comments on your patch as well, so I have been expecting a new
version.

Sorry if that was unclear!

Kind regards
Uffe

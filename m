From: dianders@chromium.org (Doug Anderson)
Date: Thu, 19 Jun 2014 09:17:32 -0700
Subject: [PATCH] clocksource: exynos-mct: Register the timer for stable
 udelay
In-Reply-To: <53A309A5.9040204@linaro.org>
References: <1403091060-5054-1-git-send-email-amit.daniel@samsung.com>
 <CAD=FV=WHK7TDdqcAd6aVs2g8rcHJx834im_4nTKHJAkUisWq4A@mail.gmail.com>
 <53A2A86E.4090903@linaro.org>
 <CAD=FV=VUomY-h2euRVWNO=ND0pUNLO5mZr_=sMm_oUSrwBssnA@mail.gmail.com>
 <53A309A5.9040204@linaro.org>
Message-ID: <CAD=FV=X0NHALPJWaszKLCLPFY-xJvT7iio=hvQCeqCz5O5c-MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

On Thu, Jun 19, 2014 at 9:02 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>> My understanding of the current status is:
>> * I posed the 64-bit version that's almost as fast as the 32-bit version.
>> * I asked if people want the 32-bit version: no answer
>> * I asked if anyone is opposed to the 64-bit version: no answer
>
>
> Yeah, that happens. I thought you were working on the 32 bits.

It was on my list of things to do today to touch base and make sure we
were on the same page.  Apparently we weren't.  ;)


>> I know that you wanted me to clean up the description of the 64-bit
>> version so I was going to do that and repost.  If there's someone
>> willing to review / ack the 32-bit version I'd be happy to do that
>> instead.  Possibly I'll do both and a maintainer can choose which to
>> apply?
>
>
> Please, resend me the patch 1/3 as it is urgent with the changelog changed.

OK, I'll do that right now, but just send it as a single patch (so I
can get it out right away).  Then I'll post up the 32-bit versions
with an implicit dependency on that patch.

-Doug

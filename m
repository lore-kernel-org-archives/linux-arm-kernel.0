From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 Jul 2015 11:36:20 +0200
Subject: [PATCH 04/13] pinctrl: tegra: Only set the gpio range if needed
In-Reply-To: <CAAObsKAH4kXdetXoj7fEZP4t09g39E4Y6QZPO4_SBu=BqstqbA@mail.gmail.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
 <1434548543-22949-5-git-send-email-tomeu.vizoso@collabora.com>
 <CACRpkdY1PPTvuF1ntiybGYoN8nHD7dojtuuJkKpUPXNjBpK1nw@mail.gmail.com>
 <CAAObsKBUoMmHOXBmEO4+8H1VVAkEHn_aFvLBOrXS5syLu5p1iA@mail.gmail.com>
 <CACRpkdahW+oXpcmyCSEYbUrsz3DPgT+HJ6h=8_J=nYOpghaXAQ@mail.gmail.com>
 <CAAObsKAH4kXdetXoj7fEZP4t09g39E4Y6QZPO4_SBu=BqstqbA@mail.gmail.com>
Message-ID: <CACRpkda+8Tt0rbFo=xYemy89ShxYanixFc=Bc2aQ7fC9ykN9FA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 10:19 AM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> On 17 July 2015 at 10:04, Linus Walleij <linus.walleij@linaro.org> wrote:

>> I don't see Stephen's ACK on them, where is it? It's not in the
>> patch and I don't see it as response to the patches.
>
> I see it in:
>
> https://lkml.kernel.org/g/1436862596-27730-4-git-send-email-tomeu.vizoso at collabora.com
>
> Which was given in:
>
> https://lkml.kernel.org/g/559D8E36.50209 at wwwdotorg.org

Hm strange I only see v1, that's why I'm confused....

> But we still need an ack for patch 1/3 before both 2/3 and 3/3 can be
> merged, because if we don't defer the probe when the pinctrl isn't
> found and just skip adding the gpio-range, there won't be no
> gpio-range set at all if the pinctrl device probes after the gpiochip
> device. Merging 2/3 now would be fine as long as we don't merge 3/3
> before 1/3.

I'll hold it back for now, bug me when you think I can merge
1/3 and 2/3.

Yours,
Linus Walleij

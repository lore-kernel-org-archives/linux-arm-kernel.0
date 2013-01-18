From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 18 Jan 2013 20:36:34 +0100
Subject: [PATCH 1/3] pinctrl: exynos: add exynos5250 SoC specific data
In-Reply-To: <00df01cdeed1$f08d73b0$d1a85b10$@samsung.com>
References: <1355399644-29417-1-git-send-email-thomas.abraham@linaro.org>
 <1355399644-29417-2-git-send-email-thomas.abraham@linaro.org>
 <CACRpkdaQ10CgoFXtk4EyqL4LWVpsdEAdrmy5R-_Rqm5fJdqS4A@mail.gmail.com>
 <CAJuYYwTZkzCXjowhKaJ253Oji07eDdEjMvNssyL1ThWtETswSQ@mail.gmail.com>
 <017801cde453$77b03eb0$6710bc10$@samsung.com>
 <CACRpkdZKB1_1U1VZfYADwWfFpBum0Qc88kWtW37h7Z05RtSJfA@mail.gmail.com>
 <00df01cdeed1$f08d73b0$d1a85b10$@samsung.com>
Message-ID: <CACRpkdYGWOqgN2=PQF7GZUuKKiQreXqaHEBmuGy4wteUzmyAqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 2:29 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Linus Walleij wrote:
>> On Thu, Dec 27, 2012 at 5:58 PM, Kukjin Kim <kgene.kim@samsung.com>
>> wrote:
>>
>> > And I think, would be clear if the config could be changed like
> following.
>> >
>> > 8<----------------------------------------------------------------------
>> > From: Kukjin Kim <kgene.kim@samsung.com>
>> > Subject: [PATCH] pinctrl: exynos: change PINCTRL_EXYNOS option
>> >
>> > Since pinctrl-exynos can support exynos4 and exynos5 so changed
>> > the option name to PINCTRL_EXYNOS for more clarity.
>> >
>> > Cc: Thomas Abraham <Thomas.abraham@linaro.org>
>> > Cc: Linus Walleij <linus.walleij@linaro.org>
>> > Cc: Grant Likely <grant.likely@secretlab.ca>
>> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Shall I take this into the pinctrl tree?
>>
> Yes, please :-)

OK I did.

> Just note, regarding Samsung pinctrl changes in the following:
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> next/pinctrl-exynos

Hm. I had to use patch -p1 < ... to apply the patch, which indicates
there may be merge clashes.

Anyway, it's merged now.

Yours,
Linus Walleij

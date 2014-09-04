From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 4 Sep 2014 10:40:11 +0200
Subject: [PATCH 00/15] PM / Domains: Cleanups and remove superfluous APIs
In-Reply-To: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAMuHMdXmfG_bpzX3HrtZPB5nV2n7UPwxGJqdpjJBqWNSnBe-Pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Wed, Sep 3, 2014 at 12:52 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> This patchset has a bit of a history and some parts of it has been posted
> earlier.
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/262725.html
>
> The intent is to simplify code for the generic power domain and also some of
> the machine specific code that uses the generic power domain.
>
> Do note, there are dependencies through this patchset, especially related to
> the ARM SoC changes, thus they all need to be kept together.

Thanks for your patch series!

I gave this series (on top of "[PATCH v2 0/9] PM / Domains: Generic OF-based
support", with one minor conflict) a quick run on r8a7791/koelsch-reference,
r8a7740/armadillo-legacy, and r8a7740/armadillo-multiplatform.
Everything looks fine.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

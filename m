From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 29 Apr 2015 16:33:11 +0200
Subject: [PATCH v6 4/4] clk: dt: Introduce binding for always-on clock
 support
In-Reply-To: <20150429141751.GR9169@x1>
References: <1428432239-4114-1-git-send-email-lee.jones@linaro.org>
 <1428432239-4114-5-git-send-email-lee.jones@linaro.org>
 <20150407191746.GA26727@lukather> <20150408081450.GB5162@x1>
 <20150408094349.GC26727@lukather> <20150408103832.GG5162@x1>
 <20150408155705.GF26727@lukather> <20150408172344.GH5162@x1>
 <20150422093446.GA28007@lukather> <20150429141751.GR9169@x1>
Message-ID: <CAMuHMdVdtoXGhK97Ky5hoVcjM6XZAZXKWELL64MFQebMpFr2Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, Apr 29, 2015 at 4:17 PM, Lee Jones <lee.jones@linaro.org> wrote:
> This useful binding should be accepted and people should not abuse
> it.  If they do and the vendor Maintainer's review and accept then
> they have no foundation for recourse.
>
> Would you prefer it if I made the warning starker?

Perhaps you can add a check for "clock-always-on" to scripts/checkpatch.pl,
to make people aware they should think twice?

Nah, people don't read documentation, don't run checkpatch, ignore compiler
warnings, etc...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

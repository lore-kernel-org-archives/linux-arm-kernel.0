From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 15 May 2017 22:22:38 +0200
Subject: [PATCH v4 0/3] arm64: dts: r8a7795: Add support for R-Car H3 ES2.0
In-Reply-To: <20170515184041.GA23926@verge.net.au>
References: <1494852253-8572-1-git-send-email-geert+renesas@glider.be>
 <20170515184041.GA23926@verge.net.au>
Message-ID: <CAMuHMdU+FWLhB4sMq3HWkMrGN2aC+inA53-DNoB2pyXAiEJ8CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, May 15, 2017 at 8:40 PM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, May 15, 2017 at 02:44:10PM +0200, Geert Uytterhoeven wrote:
>> This patch series adds support for Renesas Salvator-X and H3ULCB
>> development boards equipped with revision ES2.0 of the R-Car H3 SoC.

[...]

>> This has been tested on Salvator-X (H3 ES1.0 and ES2.0), and H3ULCB with
>> H3 ES1.1.
>>
>> This has not been tested on H3ULCB with H3 ES2.0 due to lack of
>> hardware, so perhaps you want to defer patch 3. However, adding ES2.0
>> support to both boards at the same time has its advantages (e.g. to answer
>> the question "in which kernel version do I need a DTB with 'es1' in its
>> name?").
>>
>> Thanks for applying (at least) the first two patches!
>
> Thanks, patches 1 and 2 queued up.

Thank you!

> I'd rather not take 3 until it can be tested somehow.

No problem.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

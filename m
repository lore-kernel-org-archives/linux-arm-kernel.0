From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 21 Aug 2012 20:17:19 +0200
Subject: [PATCH v2 16/31] arm64: ELF definitions
In-Reply-To: <20120821160653.GH12708@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <201208151415.39570.arnd@arndb.de>
 <20120816102300.GG31784@mudshark.cambridge.arm.com>
 <201208161237.53594.arnd@arndb.de> <20120821160653.GH12708@arm.com>
Message-ID: <CAMuHMdVEX0egzFETMJ=LA_PB+7Qc=Ph-7uxofVr__wOE-0cvLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 6:06 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> But I can see on x86 that it always reports x86_64 even if the task is
> x86_32.

Really?

$ uname -m
x86_64
$ linux32 uname -m
i686
$

On Ubuntu 2.6.32-42-generic

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

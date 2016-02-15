From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 15 Feb 2016 19:08:32 +0100
Subject: Build regressions/improvements in v4.5-rc4
In-Reply-To: <1455559593-26369-1-git-send-email-geert@linux-m68k.org>
References: <1455559593-26369-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAMuHMdVDyep0cPPB-Mh5CfRSt4Do_F_j6WMkwzjRfz_jDZLLeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 7:06 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.5-rc4[1] to v4.5-rc3[3], the summaries are:
>   - build errors: +17/-11

  + /home/kisskb/slave/src/arch/arm/include/asm/div64.h: error: 'asm'
operand has impossible constraints:  => 93:3, 111:3
  + /home/kisskb/slave/src/arch/arm/include/asm/div64.h: error: can't
find a register in class 'GENERAL_REGS' while reloading 'asm':  =>
111:3

arm-randconfig

  + error: initramfs.c: undefined reference to `__stack_chk_guard':
=> .init.text+0x373c)

i386-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/9916/ (all 262 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/9888/ (all 262 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 12 Jul 2018 09:25:15 +0200
Subject: [PATCH] ARM: defconfig: Set CONFIG_LOCALVERSION in multi
 v4t/v5/v7 defconfigs
In-Reply-To: <CAOesGMgkU6yBRpAsED2fPyuAo9Tc=YprndGdkmBVrc+0783VwQ@mail.gmail.com>
References: <20180711142649.4556-1-geert+renesas@glider.be>
 <CAOesGMgkU6yBRpAsED2fPyuAo9Tc=YprndGdkmBVrc+0783VwQ@mail.gmail.com>
Message-ID: <CAMuHMdXZ8D2a-=z69US1=KEkqkrkbFqrR-zf-Suo5uaPYhSZSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Wed, Jul 11, 2018 at 11:46 PM Olof Johansson <olof@lixom.net> wrote:
> On Wed, Jul 11, 2018 at 7:26 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > This allows to derive the kernel flavor from the kernel version at
> > runtime.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I prefer not to have this go in -- this is extremely likely to creep
> into derivative configs and as such it would have no value (you can't
> be sure it's still the same config).

Fair enough. Unfortunately we cannot prevent that from happening :-(

> /proc/config.gz is the way to keep track of exactly what config you're
> running anyway, right?

Yes, in some convoluted and hard to identify way ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 25 Aug 2015 14:47:23 +0200
Subject: [PATCH 9/9] ARM: software-based priviledged-no-access support
In-Reply-To: <20150825123800.GQ7557@n2100.arm.linux.org.uk>
References: <20150821133043.GV7557@n2100.arm.linux.org.uk>
 <E1ZSmQG-0002za-E3@rmk-PC.arm.linux.org.uk>
 <CAMuHMdVMka2mt5pFpnXfLRY2M3Sj_71MgEpthOia2C99RaP_DA@mail.gmail.com>
 <20150825104422.GO7557@n2100.arm.linux.org.uk>
 <CAMuHMdWCLcDS=64m0J09KJJ4bDtgZ1Yvq8rw7u9FE0vZkKT2cw@mail.gmail.com>
 <20150825123800.GQ7557@n2100.arm.linux.org.uk>
Message-ID: <CAMuHMdUjojHFuARpeYi5mquCsNX1Lqy2Zw2YHmg9p0DLGS9WFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 2:38 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> It's ntpdate 1:4.2.6.p5+dfsg-7 from desktop-like Debian jessie.
>
> Hmm, I think I tried at one time to install Debian on an iMX6 platform
> and gave up with it after spending 50 minutes with the installer getting
> so far, and then killing the network - it was very repeatable, and always
> happened at the same point in the installation.  I gave up with Debian
> at that point, as I didn't have lots of 50 minutes to babysit the silly
> installer (which can't ask the questions up-front) nor did I want to
> waste my monthly internet allowance on multiple failed install attempts.

debootstrap is your friend.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

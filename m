From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Jul 2017 10:39:42 +0200
Subject: [PATCH 9/9] ARM: multi_v7_defconfig: Enable DMA for Renesas
 serial ports
In-Reply-To: <CAMuHMdXb1yAgw4AVvheYhPV=V9HeDCW2NdvhJWzoSz8i-mM3TQ@mail.gmail.com>
References: <1499693302-25120-1-git-send-email-geert+renesas@glider.be>
 <1499693302-25120-10-git-send-email-geert+renesas@glider.be>
 <CANqRtoSi8x7zqwV3Gp_n0dBe4Uw6LDRvC1Lheu+GrLZNYuxAHw@mail.gmail.com>
 <CAMuHMdXb1yAgw4AVvheYhPV=V9HeDCW2NdvhJWzoSz8i-mM3TQ@mail.gmail.com>
Message-ID: <CAK8P3a1-yuxQ-m5h+u38TKoybfxrAF8XpwcB9xFYKePhukXaQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 11, 2017 at 8:59 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

> Whether we want to hide the option (and default to y if ARCH_RENESAS, i.e.
> ARM) is another question.  Note that that wouldn't reduce code maintainability,
> as the #ifdefs would be kept, and it would prevent building and testing
> with/without DMA on ARM.

arch/sh/configs/sdk7786_defconfig enables it, too, so it should at least be
a user-selectable option on SuperH if you do that.

     Arnd

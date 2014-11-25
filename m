From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 25 Nov 2014 16:08:54 +0100
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Enable shmobile platforms
In-Reply-To: <20140910004812.GB28662@verge.net.au>
References: <1409234429-1916-1-git-send-email-geert+renesas@glider.be>
 <20140910004812.GB28662@verge.net.au>
Message-ID: <CAMuHMdUWg3zDTyCGKOGxmtJxAd-y7mCz_911FnSGWSAPe=CQSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 2:48 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Aug 28, 2014 at 04:00:28PM +0200, Geert Uytterhoeven wrote:
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Based on next-20140828
>> For now excluding r8a7740/armadillo, as it fails to boot on armadillo

Armadillo failures are an issue with the bootloader (hermit), it works when
using kexec.

> r8a7794 SoC support is now queued up for v3.18.
> So I think could also be added to multi_v7_defconfig too.
> Let me know if you want an incremental patch.

Adding r8a7794 and other recent additions to shmobile_defconfig.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

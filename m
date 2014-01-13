From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 13 Jan 2014 09:02:07 +0100
Subject: [PATCH] ARM: shmobile: koelsch: Enable DEVTMPFS_MOUNT in defconfig
In-Reply-To: <20140113003811.GI15296@verge.net.au>
References: <1389525349-3722-1-git-send-email-geert@linux-m68k.org>
 <20140113003811.GI15296@verge.net.au>
Message-ID: <CAMuHMdWu80dtY_uKtd-t4eYQw3c4Vu=AqbTZ1CnDtc6yeyXiYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 1:38 AM, Simon Horman <horms@verge.net.au> wrote:
> On Sun, Jan 12, 2014 at 12:15:49PM +0100, Geert Uytterhoeven wrote:
>> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>>
>> Without this, a Debian jessie nfsroot hangs early in the boot process.
>
> If this is really necessary for Jessie to boot then I think

I think it's needed for udev. Looking in the git history for similar changes
to other defconfigs confirmed that.

> we should enabled it in all shmobile defconfigs.

Sure. Do you want me to send patches for that, or will you take care yourself?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 9 Dec 2015 10:28:22 +0100
Subject: [PATCH] ARM: shmobile: defconfig: Enable CONFIG_PRINTK_TIME
In-Reply-To: <20151201064434.GI16260@verge.net.au>
References: <1448890534-1430-1-git-send-email-geert+renesas@glider.be>
 <20151201064434.GI16260@verge.net.au>
Message-ID: <CAMuHMdWy3BWSe7ASwN4JejoJR8cDT06gSA5d+bPSRB7COR3Mzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tue, Dec 1, 2015 at 7:44 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Nov 30, 2015 at 02:35:34PM +0100, Geert Uytterhoeven wrote:
>> Enable timestamps for kernel log output to improve debugging.
>> You can always use "dmesg -t" to strip the timestamps.
>>
>> Don't specify CONFIG_LOG_BUF_SHIFT=16 while we're at it.  There's a
>> reason the default in Kconfig is higher ;-)
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thanks, I have queued this up.

Still not present in renesas-devel?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

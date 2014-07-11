From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 11 Jul 2014 16:26:03 +0200
Subject: [PATCH 10/13] [RFC] ARM: dts: Add shmobile platform device tree
 bindings documentation
In-Reply-To: <20140711091720.GO12420@verge.net.au>
References: <1404908623-909-1-git-send-email-geert+renesas@glider.be>
 <1404908623-909-11-git-send-email-geert+renesas@glider.be>
 <20140711091720.GO12420@verge.net.au>
Message-ID: <CAMuHMdXP6GfO7OEnXU8x4Sn5j8_tA2nnrFANr1sriB-B4BYoOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Jul 11, 2014 at 11:17 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Jul 09, 2014 at 02:23:40PM +0200, Geert Uytterhoeven wrote:
>> Add Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
>> Documentation, listing supported SoCs and boards.
>>
>> This allows to use checkpatch to validate DTSes referring to Renesas
>> shmobile SoCs, and boards containing those SoCs.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: linux-arm-kernel at lists.infradead.org
>
> Thanks Geert,
>
> from my point of view this seems nice. Is there a reason it is marked as an RFC?

>From the cover letter:

"The last 4 patches contain compatible strings for new R-Car Gen2 SoCs,
 which are not yet in active use, hence the RFC status."

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

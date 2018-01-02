From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 2 Jan 2018 15:50:19 +0100
Subject: [PATCH] soc: renesas: rcar-sysc: Mark rcar_sysc_matches[]
 __initconst
In-Reply-To: <20171220082527.k7wldjwjxut3j4xz@verge.net.au>
References: <1513698884-26663-1-git-send-email-geert+renesas@glider.be>
 <20171220082527.k7wldjwjxut3j4xz@verge.net.au>
Message-ID: <CAMuHMdXGVM1qkBNPDN_rrN5mby-iGy8s8VgEz_KmYswmufVohQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Dec 20, 2017 at 9:25 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Dec 19, 2017 at 04:54:44PM +0100, Geert Uytterhoeven wrote:
>> rcar_sysc_matches[] is used only by rcar_sysc_pd_init(), which is
>> __init.  Hence mark rcar_sysc_matches[] __initconst.
>>
>> This frees another 1764 bytes (arm32/shmobile_defconfig) or 1000 bytes
>> (arm64/renesas_defconfig) of memory after kernel init.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Reviewed-by: Simon Horman <simon.horman@netronome.com>

Thank you.
Please note this is a patch intended for your soc-for-v4.16 branch ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

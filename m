From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 15 Sep 2017 10:05:23 +0200
Subject: [PATCH 1/8] ARM: dts: r8a7745: Add APMU node and second CPU core
In-Reply-To: <20170915074551.GF3924@verge.net.au>
References: <1505322341-9480-1-git-send-email-chris.paterson2@renesas.com>
 <1505322341-9480-2-git-send-email-chris.paterson2@renesas.com>
 <20170915074551.GF3924@verge.net.au>
Message-ID: <CAMuHMdWrMiHQz_Tadh3R00n+zeSnGOW-o=skbK-R-yD6Z-x2+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon, Fabrizio,

On Fri, Sep 15, 2017 at 9:45 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Sep 13, 2017 at 06:05:34PM +0100, Chris Paterson wrote:
>> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>>
>> Add DT node for the Advanced Power Management Unit (APMU), add the
>> second CPU core, and use "renesas,apmu" as "enable-method".
>>
>> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
>> ---
>> This patch is based on renesas-devel-20170913-v4.13.
>
> Hi,
>
> with reference to "[PATCH v3 0/3] ARM: renesas: Enable SMP on R-Car E2"
> is the CNTVOFF initialised in the boot loader of boards (in upstream)
> for this SoC? If not I expect you will have trouble with the arch timer
> on secondary CPU cores.

Exactly my question.

Fabrizio: Given your feedback on "[PATCH v3 0/3] ARM: renesas: Enable SMP on
R-Car E2", I think SMP enablement on RZ/G1E has to be postponed until "ARM:
shmobile: rcar-gen2: Make sure CNTVOFF is initialized on CA7/15" has been
accepted upstream.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 15 Jan 2015 09:44:24 +0100
Subject: linux-next: manual merge of the renesas tree with the arm-soc tree
In-Reply-To: <20150115113840.71ab0a39@canb.auug.org.au>
References: <20150115113840.71ab0a39@canb.auug.org.au>
Message-ID: <CAMuHMdVjtVfTQyqMZYeXiPCMoeyxxUv-ikxRvM3uw9FCGTQ+BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 1:38 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Today's linux-next merge of the renesas tree got a conflict in
> arch/arm/boot/dts/Makefile between commit cb612390e546 ("ARM: dts: Only
> build dtb if associated Arch and/or SoC is enabled") from the arm-soc
> tree and commits 9ccba8abd0a7 ("ARM: shmobile: kzm9g: Build DTS for
> Multiplatform") and 93c9f0228a3d ("ARM: shmobile: kzm9g-reference:
> Remove board C code and DT file") from the renesas tree.
>
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Your resolution is correct.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

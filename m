From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 8 Nov 2018 11:49:32 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.20
In-Reply-To: <CAOesGMjosJGENSm8jjAaZxcr4ehjBB5LF7OQ8PJR-J2kMktfWQ@mail.gmail.com>
References: <cover.1541514075.git.horms+renesas@verge.net.au>
 <CAOesGMjosJGENSm8jjAaZxcr4ehjBB5LF7OQ8PJR-J2kMktfWQ@mail.gmail.com>
Message-ID: <CAMuHMdX-oLaQ8LHRiUjWLHOQ020GKLbbuDURuy0K_Jsp32B17g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Wed, Nov 7, 2018 at 5:03 PM Olof Johansson <olof@lixom.net> wrote:
> On Wed, Nov 7, 2018 at 3:25 AM Simon Horman <horms+renesas@verge.net.au> wrote:
> > * R-Car V3H (r8a77980) based Condor board
> >   - Switch from EtherAVB to GEther to match offical boards
> >
> > * RZ/G2E (ra8774c0) SoC: correct documentation of part number
>
> I have to admit, Renesas part numbers have got to be _really_ hard to
> deal with for anyone who has even the slightest hint of dyslexia. :-)

Yeah, for some on them, you can trick people into believing Renesas did
switch to "r" + a truncated commit ID in the HDL source repository ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 10 Jul 2018 16:51:48 +0200
Subject: [PATCH] MAINTAINERS: arm64: Remove boot/dts/ directory from arm64
 entry
In-Reply-To: <CAOesGMhpkNvWiaqG=6V6KSshGzwZeSZDF-+4H7JVZqykxR+04A@mail.gmail.com>
References: <1530879736-7650-1-git-send-email-will.deacon@arm.com>
 <CAMuHMdUqRXde5DNgK6ih+ivuwY9HFbcWwbx_x3q5PmFcrGi0pQ@mail.gmail.com>
 <CAOesGMhpkNvWiaqG=6V6KSshGzwZeSZDF-+4H7JVZqykxR+04A@mail.gmail.com>
Message-ID: <CAMuHMdXMj9q62wPMR3HXnZaFNK+as35t83y6OYSpDXuz8=SCrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Tue, Jul 10, 2018 at 4:43 PM Olof Johansson <olof@lixom.net> wrote:
> On Tue, Jul 10, 2018 at 12:25 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Fri, Jul 6, 2018 at 2:22 PM Will Deacon <will.deacon@arm.com> wrote:
> >> The arm-soc tree does a good job handling .dts files, so exclude them
> >> from the ARM64 entry in MAINTAINERS.
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Signed-off-by: Will Deacon <will.deacon@arm.com>
> >
> > Thanks for your patch!
> >
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -2264,6 +2264,7 @@ L:        linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> >>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
> >>  S:     Maintained
> >>  F:     arch/arm64/
> >> +X:     arch/arm64/boot/dts/
> >>  F:     Documentation/arm64/
> >
> > Please note that this does not cause checkpatch to point to the arm-soc
> > tree, but does drop the reference to linux-arm-kernel, which may not
> > be intentional?
>
> It is intentional. If people start sending patches to arm at kernel.org

They won't, as that address is nowhere to be found in MAINTAINERS ;-)

I really meant linux-arm-kernel at lists.infradead.org

> we'll drown. The model relies on platform maintainers picking up the
> contents and sending us pull requests.

OK. So a few platform maintainers still have to add their dts directory to
their MAINTAINERS entry.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

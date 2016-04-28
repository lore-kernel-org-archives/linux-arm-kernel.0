From: horms@verge.net.au (Simon Horman)
Date: Fri, 29 Apr 2016 09:22:00 +1000
Subject: [GIT PULL] Renesas ARM Based SoC DT PM Domain Updates for v4.7
In-Reply-To: <CAMuHMdWnt4ceLuu-eddbMQDSFvHHVgoyUNM2V=SYO9R0XrJDMQ@mail.gmail.com>
References: <cover.1461730638.git.horms+renesas@verge.net.au>
 <5702417.rnCUR69ruo@wuerfel>
 <CAMuHMdWnt4ceLuu-eddbMQDSFvHHVgoyUNM2V=SYO9R0XrJDMQ@mail.gmail.com>
Message-ID: <20160428232159.GB18128@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Apr 28, 2016 at 06:27:25PM +0200, Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Thu, Apr 28, 2016 at 5:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 27 April 2016 14:20:34 Simon Horman wrote:
> >> Please consider these Renesas ARM based SoC DT pm-domain updates for v4.7.
> >>
> >> This pull requests is based on a merge of:
> >>
> >> * "[GIT PULL] Second Round of Renesas ARM Based SoC R-Car SYSC Updates for
> >>   v4.7", tagged as renesas-rcar-sysc2-for-v4.7, which you have already
> >>   pulled.
> >> * "[GIT PULL v2] Renesas ARM Based SoC DT Updates for v4.7",
> >>   tagged as renesas-dt-for-v4.7, which you have also already pulled.
> >>
> >> The reason for the somewhat tedious base on
> >> renesas-rcar-sysc2-for-v4.7, which provides driver changes,
> >> is a hard run-time dependency.
> >>
> >> I also have a similar set of changes for arm64 which I will send separately.
> >
> > Ok, I've started a next/late branch for this now, but unless something
> > else comes up that needs to be sent much later, I expect to submit
> > this as the last pull request at the same time as all the other ones
> > for 4.7.
> 
> Thanks!

Yes, thanks for your understanding.

FWIW, I think "Renesas ARM64 Based SoC DT PM Domain Updates for v4.7" needs
to be handled the in a similar way. Its a similar pair of changes for the
r8a7795 SoC.

Everything else I have queued up for v4.7 has been pulled and I do
not intend to queue up any more non-fix changes for v4.7.

> > For further clarification, am I right reading the above as meaning that
> > a 4.7 kernel is expected to still work with the dts files from 4.6,
> > but not the other way round?
> 
> That's correct.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

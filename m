From: horms@verge.net.au (Simon Horman)
Date: Fri, 15 May 2015 09:44:14 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.2
In-Reply-To: <CAMuHMdUgQ0xc0WVGHTjUK6Vx-29HFupsqmKJ1nctwVK1P=WjsQ@mail.gmail.com>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
 <CAMuHMdUgQ0xc0WVGHTjUK6Vx-29HFupsqmKJ1nctwVK1P=WjsQ@mail.gmail.com>
Message-ID: <20150515004413.GG26927@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 05:37:35PM +0200, Geert Uytterhoeven wrote:
> On Thu, May 14, 2015 at 3:06 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> >
> > Please consider these Renesas ARM based SoC DT updates for v4.2.
> >
> >
> > The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:
> >
> >   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.2
> >
> > for you to fetch changes up to 7706993e2deb75022dbcfc3043890aa1a0020189:
> >
> >   ARM: shmobile: r8a7791: Enable DMA for HSUSB (2015-05-12 08:55:16 +0900)
> >
> > ----------------------------------------------------------------
> > Renesas ARM Based SoC DT Updates for v4.2
> >
> > * Enable DMA for HSUSB on r8a7790 and r8a7791 SoCs
> > * Configure the HOME key as wake-up source on kzm9g board
> > * Use generic names for device nodes on SH Mobile SoCs and boards
> > * Add "nor-jedec" compatible value to SH Mobile boards
> 
> Please note Brian is reconsidering this compatible value.
> If the binding will be changed (which has to happen before v4.1 is released),
> the above must be changed, too.

Noted. I believe we can leave this pull-request as is and
follow up with any changes as needed.

> > * Add IRQC clock to r8a73a4, r8a779* SoCs
> > * Remove MSIOF address from r8a7790 and r8a7791 SoCs
> >
> > ----------------------------------------------------------------
> > Geert Uytterhoeven (25):
> 
> >       ARM: shmobile: henninger dts: Add "nor-jedec" compatible value
> >       ARM: shmobile: bockw-reference dts: Add "nor-jedec" compatible value
> >       ARM: shmobile: lager dts: Add "nor-jedec" compatible value
> >       ARM: shmobile: bockw dts: Add "nor-jedec" compatible value
> >       ARM: shmobile: koelsch dts: Add "nor-jedec" compatible value
> 
> 
> 
> 
> -- 
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

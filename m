From: horms@verge.net.au (Simon Horman)
Date: Fri, 19 Jun 2015 17:17:10 +0900
Subject: [PATCH 00/15] ARM: shmobile: Remove legacy sh73a0/kzm9g and
 r8a7740/armadillo
In-Reply-To: <CAMuHMdUqO2_rMpx0akeS1j+pNmQ_S150ei0B6a1ubFu_iTBF3g@mail.gmail.com>
References: <1434533491-21979-1-git-send-email-geert+renesas@glider.be>
 <20150619034052.GA22912@verge.net.au>
 <CAMuHMdUqO2_rMpx0akeS1j+pNmQ_S150ei0B6a1ubFu_iTBF3g@mail.gmail.com>
Message-ID: <20150619081709.GB434@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 09:30:56AM +0200, Geert Uytterhoeven wrote:
> On Fri, Jun 19, 2015 at 5:41 AM, Simon Horman <horms@verge.net.au> wrote:
> > [ CC Linus, Laurent, linux-gpio ]
> >
> > On Wed, Jun 17, 2015 at 11:31:16AM +0200, Geert Uytterhoeven wrote:
> >>       Hi Simon, Magnus,
> >>
> >> The KZM-A9-GT and Armadillo-800 EVA boards are now sufficiently
> >> supported by DT-based and board-less SH-Mobile AG5 (sh73a0) and R-Mobile
> >> A1 (r8a7740) multi-platform kernels.
> 
> >> Hence this patch series removes legacy board and SoC code for
> >> sh73a0/kzm9g and r8a7740/armadillo.
> 
> >> Geert Uytterhoeven (15):
> >>   ARM: shmobile: Remove legacy board code for KZM-A9-GT
> >>   ARM: shmobile: Remove legacy kzm9g_defconfig
> >>   ARM: shmobile: Drop sh73a0-kzm9g.dtb for legacy builds
> >>   ARM: shmobile: Remove legacy SoC code for SH-Mobile AG5
> >>   ARM: shmobile: Remove legacy board code for Armadillo-800 EVA
> >>   ARM: shmobile: Remove legacy armadillo800eva_defconfig
> >>   ARM: shmobile: Drop r8a7740-armadillo800eva.dtb for legacy builds
> >>   ARM: shmobile: Remove legacy SoC code for R-Mobile A1
> >>   ARM: shmobile: Remove unused dma-register.h
> >>   ARM: shmobile: R-Mobile: Remove legacy PM Domain code
> >>   ARM: shmobile: Remove obsolete zboot support
> >
> > I have queued up the above patches for v4.3.
> 
> Thanks!
> 
> >>   pinctrl: sh-pfc: sh73a0: Remove obsolete multi-platform check
> >>   pinctrl: sh-pfc: Remove obsolete sh73a0 platform_device_id entry
> >>   pinctrl: sh-pfc: r8a7740: Remove obsolete multi-platform check
> >>   pinctrl: sh-pfc: Remove obsolete r8a7740 platform_device_id entry
> >
> > As the above patches are sh-pfc patches they would typically
> > be steered through Linus's tree via Laurent. If they wish
> > to take that path then I'm happy for this to be attached:
> >
> > Acked-by: Simon Horman <horms+renesas@verge.net.au>
> >
> > FWIW the above path is the one that the removal of mackerel/sh7372 took.
> >
> > Alternatively, I am happy to take the above sh-pfc patches through
> > my tree but I would like to do so with an Ack from at least Linus.
> 
> I didn't CC Linus and linux-gpio at this stage yet, to prevent the pfc
> patches from getting applied prematurely.
> But things have gone more smoothly (esp. w.r.t. board staging) than expected,
> which is always pleasant.
> 
> I can resend later, I have a few more areas of sh73a0/r8a7740 cleanup
> outside arch/arm/mach-shmobile waiting anyway...

I'm happy with whatever timing you think is best.

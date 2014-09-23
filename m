From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 23 Sep 2014 15:17:17 +0900
Subject: [PATCH 2/2] ARM: dts: Add rtc_src clk for s3c-rtc on
 exynos5250-snow
References: <1410954633-27025-1-git-send-email-javier.martinez@collabora.co.uk>
 <1410954633-27025-3-git-send-email-javier.martinez@collabora.co.uk>
 <CAD=FV=W7xJ01m2oLtuDnogOmrpwpztbir=59oSWU6oojFYUWKw@mail.gmail.com>
 <5419ADF9.3010509@suse.de>
Message-ID: <00f801cfd6f6$07e10500$17a30f00$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> > 
> Andreas F?rber wrote:

[...]

> > > Kukjin: Andreas's patch series was Reviewed long ago I think and by
> > > now I'd imagine it's got some conflicts due to it not having been
> > > applied in a timely fashion.  Perhaps you could fix it up for Andreas
> > > (since he's already rebased it several times) and land it?
> > >
> > > If I had to guess, outstanding from Andreas's series (patchwork IDs listed):
> > >
> > > 4751131 New          [v7] ARM: dts: Prepare node labels for exynos5250
> > > 4664801 New          [v6,04/10] ARM: dts: Clean up exynos5250-snow
> > > 4664771 New          [v6,05/10] ARM: dts: Fill in bootargs for exynos5250-snow
> > > 4664731 New          [v6,06/10] ARM: dts: Clean up exynos5250-smdk5250
> > > 4664751 New          [v6,07/10] ARM: dts: Clean up exynos5250-arndale
> > > 4664711 New          [v6,08/10] ARM: dts: Fix apparent GPIO typo in
> > > exynos5250-arndale
> > > 4664681 New          [v6,09/10] ARM: dts: Simplify USB3503 on exynos5250-arndale
> > > 4664691 New          [v6,10/10] ARM: dts: Add exynos5250-spring device tree
> >
> > Yes, Kukjin told me not to resend anything, and I haven't heard back
> > from him since his Kernel Summit trip.
> >
> Sorry about that and I thought I took them :( I'll sort them out tonight
> including this series together.
> 
Hmm...since some conflicts with dp and mmc_slot related patches, I couldn't,
but Andreas' patches will be handled by tonight :(

- Kukjin

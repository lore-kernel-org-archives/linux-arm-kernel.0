From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 27 Apr 2017 21:48:42 +0200
Subject: [GIT PULL 2/2] arm64 dts: exynos: Last round for v4.12
In-Reply-To: <CAK8P3a1HA6cio=hboc7=BYwJn-i6RzCP1uzcCVvcQwt4wtB3Tw@mail.gmail.com>
References: <20170421164050.7404-1-krzk@kernel.org>
 <20170421164050.7404-2-krzk@kernel.org>
 <CAK8P3a1HA6cio=hboc7=BYwJn-i6RzCP1uzcCVvcQwt4wtB3Tw@mail.gmail.com>
Message-ID: <20170427194842.exdjbaqta75bs2jy@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 09:46:03PM +0200, Arnd Bergmann wrote:
> On Fri, Apr 21, 2017 at 6:40 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > The following changes since commit e3c07546747cdec07ff15c984bc6cebc9c9f788c:
> >
> >   arm64: dts: exynos: Add the burst and esc clock frequency properties to DSI node (2017-03-08 08:55:39 +0200)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.12-2
> >
> > for you to fetch changes up to 5dccc9873c4af60f4478b3ef54267353f25cc301:
> >
> >   arm64: dts: exynos: Use - instead of @ for DT OPP entries (2017-04-20 18:10:05 +0200)
> >
> > ----------------------------------------------------------------
> > Second update of  Samsung DeviceTree ARM64 for v4.12:
> >  - Fix DTC warnings in Exynos ARM64 Device Tree sources.
> >  - Add panel node to TM2E board.
> >
> > ----------------------------------------------------------------
> > Hoegeun Kwon (1):
> >       arm64: dts: exynos: Add support for s6e3hf2 panel device on TM2e board
> >
> > Viresh Kumar (1):
> >       arm64: dts: exynos: Use - instead of @ for DT OPP entries
> >
> >  arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi | 48 ++++++++++++-------------
> >  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts | 11 ++++++
> >  arch/arm64/boot/dts/exynos/exynos5433.dtsi     | 50 +++++++++++++-------------
> >  3 files changed, 60 insertions(+), 49 deletions(-)
> 
> I pulled the updated version into next/dt64, thanks,

Thanks! Do not forget also about next/dt (this wasn't updated so just
tags/samsung-dt-4.12-2).

Best regards,
Krzysztof

From: olof@lixom.net (Olof Johansson)
Date: Mon, 12 Jan 2015 14:24:57 -0800
Subject: [GIT PULL] Renesas ARM Based SoC DT Cleanups for v3.20
In-Reply-To: <cover.1419809027.git.horms+renesas@verge.net.au>
References: <cover.1419809027.git.horms+renesas@verge.net.au>
Message-ID: <20150112222457.GH22090@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 29, 2014 at 10:43:39AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC DT cleanups for v3.20.
> 
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-cleanups-for-v3.20
> 
> for you to fetch changes up to 338d1f0b5e877eae51c885da81d86b0efd6373e7:
> 
>   ARM: shmobile: kzm9g-reference dts: Replace status value "ok" by "okay" (2014-12-21 16:55:32 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC DT Cleanups for v3.20
> 
> * Replace status value "ok" with "okay"
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (7):
>       ARM: shmobile: genmai dts: Replace status value "ok" by "okay"
>       ARM: shmobile: armadillo800eva dts: Replace status value "ok" by "okay"
>       ARM: shmobile: lager dts: Replace status value "ok" by "okay"
>       ARM: shmobile: henninger dts: Replace status value "ok" by "okay"
>       ARM: shmobile: koelsch dts: Replace status value "ok" by "okay"
>       ARM: shmobile: alt dts: Replace status value "ok" by "okay"
>       ARM: shmobile: kzm9g-reference dts: Replace status value "ok" by "okay"
> 
>  arch/arm/boot/dts/r7s72100-genmai.dts         |  2 +-
>  arch/arm/boot/dts/r8a7740-armadillo800eva.dts |  4 ++--
>  arch/arm/boot/dts/r8a7790-lager.dts           | 12 ++++++------
>  arch/arm/boot/dts/r8a7791-henninger.dts       |  4 ++--
>  arch/arm/boot/dts/r8a7791-koelsch.dts         |  6 +++---
>  arch/arm/boot/dts/r8a7794-alt.dts             |  4 ++--
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts  |  2 +-
>  7 files changed, 17 insertions(+), 17 deletions(-)

Thanks. This would normally go into a next/cleanup branch but I'm suspecting
that'll just be conflict prone so I merged this into next/dt this time.


-Olof

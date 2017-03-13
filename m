From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 13 Mar 2017 15:41:29 +0100
Subject: [GIT PULL] Reset controller changes for v4.12
In-Reply-To: <1488965177.2467.7.camel@pengutronix.de>
References: <1488965177.2467.7.camel@pengutronix.de>
Message-ID: <1489416089.2288.69.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-03-08 at 10:26 +0100, Philipp Zabel wrote:
> Dear arm-soc maintainers,
> 
> Please consider merging this tag, which adds new drivers for i.MX7 and
> Arria10, removes module code from non-modular drivers, and fixes a build
> warning in the uniphier driver and the nr_resets property usage of the
> socfpga driver.
> 
> regards
> Philipp
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.12
> 
> for you to fetch changes up to 2fd14a1f3d3a1835c401a21f2d813030a97eab7d:
> 
>   reset: Add Altera Arria10 SR Reset Controller (2017-03-08 09:36:45 +0100)
> 
> ----------------------------------------------------------------
> Reset controller changes for v4.12
> 
> - make reset drivers with bool Kconfig options explicitly non-modular
> - fix uniphier non-static symbol warnings
> - fix socfpga nr_resets property
> - new drivers for the Arria10 and i.MX7 system reset controllers
> 
> ----------------------------------------------------------------
> Andrey Smirnov (1):
>       reset: Add i.MX7 SRC reset driver
> 
> Paul Gortmaker (4):
>       reset: meson: make it explicitly non-modular
>       reset: oxnas: make it explicitly non-modular
>       reset: ath79: make it explicitly non-modular
>       reset: pistachio: make it explicitly non-modular
> 
> Rojhalat Ibrahim (1):
>       reset-socfpga: Fix nr_resets property
> 
> Thor Thayer (3):
>       dt-bindings: mfd: Add Altera Arria10 SR Reset Controller bindings

                    ^^^

I just noticed that technically this patch would need MFD maintainer
approval for me to merge it through the reset tree. So if you have not
acted on this pull request yet, please hold back and I'll send a new one
without that patch or with the necessary approval.

regards
Philipp

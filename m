From: olof@lixom.net (Olof Johansson)
Date: Sat, 21 Jul 2018 15:04:59 -0700
Subject: [GIT PULL] Reset controller changes for v4.19
In-Reply-To: <1532099182.3438.3.camel@pengutronix.de>
References: <1532099182.3438.3.camel@pengutronix.de>
Message-ID: <20180721220459.5wlppuwpgmfebhbo@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 05:06:22PM +0200, Philipp Zabel wrote:
> Dear arm-soc maintainers,
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
> ? Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the Git repository at:
> 
> ? git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.19
> 
> for you to fetch changes up to 6b39fd590aebca1a6a4c827f29f14d2b6df3939d:
> 
> ? reset: uniphier: add reset control support for SPI (2018-07-19 11:19:47 +0200)
> 
> ----------------------------------------------------------------
> Reset controller changes for v4.19
> 
> This adds new drivers and bindings for the SDM845 AOSS (always on
> subsystem) reset controller and for the Uniphier USB3 core reset.
> SPI controller resets are added to the Uniphier reset driver.
> 
> ----------------------------------------------------------------
> Kunihiko Hayashi (4):
> ??????reset: simple: export reset_simple_ops to be referred from modules
> ??????dt-bindings: reset: uniphier: add USB3 core reset support
> ??????reset: uniphier: add USB3 core reset control
> ??????reset: uniphier: add reset control support for SPI
> 
> Sibi Sankar (2):
> ??????dt-bindings: reset: Add AOSS reset bindings for SDM845 SoCs
> ??????reset: qcom: AOSS (always on subsystem) reset controller

Merged, thanks!


-Olof

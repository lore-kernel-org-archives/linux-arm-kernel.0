From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Oct 2017 22:38:53 +0200
Subject: [GIT PULL] Reset controller changes for v4.15
In-Reply-To: <1508405198.7665.4.camel@pengutronix.de>
References: <1508405198.7665.4.camel@pengutronix.de>
Message-ID: <CAK8P3a33AWOMuKwFeD+CES0iLyFjnCSXs0uP3RmfSpGr+yy_Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 11:26 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Dear arm-soc-maintainers,
>
> please consider merging this tag for v4.15. It adds ARC AX10x reset
> support, merged from a separate branch for synchronisation with the ARC
> tree, Stratix10 reset support, Meson GX reset level controls, and PXs3
> and ethernet reset controls for Uniphier.
> The socfpga, stm32, (most of) sunxi, and zx2967 drivers are merged into
> a common simple-reset driver.

Pulled into next/drivers, thanks!

      Arnd

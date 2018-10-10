From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Oct 2018 13:45:14 +0200
Subject: [GIT PULL] Reset controller changes for v4.20
In-Reply-To: <1539078706.6678.1.camel@pengutronix.de>
References: <1539078706.6678.1.camel@pengutronix.de>
Message-ID: <CAK8P3a3TjaYoQvu3aDDHoutTqrzHegmg=CpNrsFHFBaGkx+xBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/9/18, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Dear arm-soc maintainers,
>
> The following changes since commit
> ----------------------------------------------------------------
> Reset controller changes for v4.20
>
> This adds a new driver for the PDC Global (Power Domain Controller)
> reset controller found on Qualcomm SDM845 SoCs, fixes a potential
> use-after-free issue in reset_controller_dev.of_xlate() callbacks
> from __of_reset_control_get(), and trivially fixes a documentation
> grammar issue.
>

Pulled into next/drivers, thanks!

      Arnd

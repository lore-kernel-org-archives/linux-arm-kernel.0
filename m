From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Oct 2018 16:13:55 +0200
Subject: [GIT PULL] more dts changes for omaps for v4.20
In-Reply-To: <pull-1538491958-348872@atomide.com>
References: <pull-1538491958-348872@atomide.com>
Message-ID: <CAK8P3a37xraYEXZs8bQDD76NpsdcajCeZQAonWqbf6Vu5mLiEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 2, 2018 at 4:53 PM Tony Lindgren <tony@atomide.com> wrote:
> More devicetree changes for omap variants
>
> There's a patch for previously merged dts changes to remove the last
> remaining use of legacy phy_id property.
>
> For dra7, we have a non-urgent PCIe dts fix, enable a PCIe errata for
> unaligned access.
>
> For omap5, we enable omap5 USB OTG mode for DWC3 controller.
>
> And we add support for am335x based Moxa UC-2100 series of industrial
> computers.

Pulled into next/dt, thanks!

      Arnd

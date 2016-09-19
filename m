From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Sep 2016 17:52:58 +0200
Subject: [GIT PULL] Amlogic driver updates for v4.9, 2nd round
In-Reply-To: <7hoa3ql2y7.fsf@baylibre.com>
References: <7hoa3ql2y7.fsf@baylibre.com>
Message-ID: <3231263.PDDhXyghVb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 14, 2016 12:02:40 PM CEST Kevin Hilman wrote:
> Amlogic driver updates for v4.9, 2nd round
> - media: update IR support for newer SoCs
> - firmware: add secure monitor driver
> - net: new stmmac glue driver
> - usb: udd DWC2 support for meson-gxbb
> - clocks: expose more clock IDs for use by DT
> - DT binding updates
> 

Pulled into next/late. I think in a  case like this, separate
branches would have been a bit nicer, as this branch mixes some things
that are not really related.

> ----------------------------------------------------------------
> Alexander M?ller (6):
>       clk: meson: Rename meson8b-clkc.c to reflect gxbb naming convention
>       meson: clk: Move register definitions to meson8b.h
>       meson: clk: Rename register names according to Amlogic datasheet
>       clk: meson: Copy meson8b CLKID defines to private header file
>       gxbb: clk: Adjust MESON_GATE macro to be shared with meson8b
>       meson: clk: Add support for clock gates

I also note that some of the subject lines are inconsistent regarding
the "clk: meson:" vs "gxbb: clk:" part.

	Arnd

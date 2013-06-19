From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Wed, 19 Jun 2013 11:29:00 +0200
Subject: [PATCH 0/4] ARM: dts: OMAP3: Updates for Overo
In-Reply-To: <1370962189-9689-1-git-send-email-florian.vaussard@epfl.ch>
References: <1370962189-9689-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <51C179DC.9040605@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Benoit,

Any comments on this series?

Regards,
Florian

On 06/11/2013 04:49 PM, Florian Vaussard wrote:
> Hello,
>
> This series performs several updates to omap3-overo and omap3-tobi.
> Patch 1 is necessary to patch 2 for the IRQ constant. The SMSC911X is
> largely taken from omap3-igep.
>
> Regards,
>
> Florian
>
> Florian Vaussard (4):
>    ARM: dts: OMAP3: Include IRQ header
>    ARM: dts: omap3-tobi: Add SMSC911X node
>    ARM: dts: omap3-tobi: Correct polarity for GPIO LED
>    ARM: dts: omap3-overo: Add default trigger for TWL4030 LED
>
>   arch/arm/boot/dts/omap3-overo.dtsi |    1 +
>   arch/arm/boot/dts/omap3-tobi.dts   |   50 +++++++++++++++++++++++++++++++++++-
>   arch/arm/boot/dts/omap3.dtsi       |    1 +
>   3 files changed, 51 insertions(+), 1 deletions(-)
>

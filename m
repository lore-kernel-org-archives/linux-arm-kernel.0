From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 11 Feb 2014 14:04:29 -0500
Subject: [PATCH 0/2] Marvell Armada 375 and 38x pinctrl drivers
In-Reply-To: <1392051896-19178-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392051896-19178-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140211190429.GD27395@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 06:04:54PM +0100, Thomas Petazzoni wrote:
> Linus,
> 
> Here are two patches that add the pinctrl drivers for two new Marvell
> ARM SOCs that belong to the mach-mvebu family: the Armada 375 and the
> Armada 380/385. They are based on Cortex-A9 CPU cores, and share a
> number of peripherals with their predecessors in the mach-mvebu
> family. pinctrl-wise, they have a completely similar register layout
> than Armada 370/XP, so only a list of pins and functions has to be
> introduced, and therefore the drivers are straightforward.
> 
> The core support (arch/arm/mach-mvebu) for these SOCs will be posted
> shortly, and we're aiming at having this merged for 3.15 if possible.
> 
> Thanks!
> 
> Thomas
> 
> Thomas Petazzoni (2):
>   pinctrl: mvebu: add pin-muxing driver for the Marvell Armada 375
>   pinctrl: mvebu: add pin-muxing driver for the Marvell Armada 380/385
> 
>  .../pinctrl/marvell,armada-375-pinctrl.txt         |  81 ++++
>  .../pinctrl/marvell,armada-38x-pinctrl.txt         |  79 ++++
>  drivers/pinctrl/mvebu/Kconfig                      |   8 +
>  drivers/pinctrl/mvebu/Makefile                     |   2 +
>  drivers/pinctrl/mvebu/pinctrl-armada-375.c         | 441 ++++++++++++++++++++
>  drivers/pinctrl/mvebu/pinctrl-armada-38x.c         | 445 +++++++++++++++++++++
>  6 files changed, 1056 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
>  create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-375.c
>  create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-38x.c

For the whole series,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

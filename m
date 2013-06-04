From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Jun 2013 14:19:30 +0200
Subject: [GIT PULL 0/5] ux500 changes for v3.11
Message-ID: <CACRpkda7LTeamKWyPVRy1_iOkAvGzb_XZ3sBNPLR_tNerKG4wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

These are five (5) pull requests for ux500 stuff for v3.11
that I've got queued up. I've done my best to split onto relevant
topic branches, but feel free to merge these any way you like.

1: ux500-core: misc ux500 CPU/SoC changes
2: ux500-clksrc: clocksource changes
3: ux500-pinctrl: pinctrl tables
4: ux500-dma40: DMA40 device tree and refactoring
5: ux500-devicetree: device tree updates

The last two (DMA40 and devicetree) will have a conflict in
arch/arm/mach-ux500/cpu-db8500.c as the DMA40 patch
set removes DMA related platform data.

Typically 4 & 5 are also the larges pull requests so I won't
try to merge them to resolve that conflict, instead I dump
this on you...

Have a look and see what you think. All patches have been
reviewed and ACKed as far as possible and now we need
some linux-next rotation.

I have a sixth branch with defconfig changes but that should
possibly even go in after the merge window. I'm holding it back
for now.

Yours,
Linus Walleij

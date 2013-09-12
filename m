From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 12 Sep 2013 15:27:43 -0700
Subject: [PATCH v4 0/2] ARM: dts: Beaglebone MMC fixes
In-Reply-To: <1379010935-25943-1-git-send-email-koen@dominion.thruhere.net>
 (Koen Kooi's message of "Thu, 12 Sep 2013 20:35:31 +0200")
References: <1379010935-25943-1-git-send-email-koen@dominion.thruhere.net>
Message-ID: <87y571r7z4.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Koen Kooi <koen@dominion.thruhere.net> writes:

> Here are two patches to fix MMC on beaglebone, one fixes card detect on BBW,
> the other adds the eMMC entry for BBB and its fixed regulator. After that mmc1
> gets a nice speed boost by moving to 4-bit mode and LED triggers get assigned.
>
> This series depends on:
>
> http://comments.gmane.org/gmane.linux.kernel.stable/63648
> https://lkml.org/lkml/2013/9/10/454
> http://comments.gmane.org/gmane.linux.kernel.mmc/22381
>
> Or as git-cherry would put it:
>
> [koen at rrMBP patches]$ git cherry -v
> + 564fc88cc64387af5312e2abd8019c75a13223b2 ARM: OMAP2+: am335x-bone*: add DT for BeagleBone Black
> + e5133ed98acc1c3e01c370b851041a8ca629cd15 ARM: EDMA: Fix clearing of unused list for DT DMA resources
> + ac71bb58605d3bdd5d14af770a639fb3ff11c612 ARM: dts: add AM33XX EDMA support
> + 31a8270a299c57c7de7510f44d9dc36fd1787243 ARM: dts: add AM33XX SPI DMA support
> + 4fa0a4cb9ea17da30cf43085c03e5ec1361a4fc2 ARM: dts: add AM33XX MMC support and documentation
> + 0553f50bd45f019a0cc11050e2f20bddbf07dfe0 ARM: dts: am335x-bone: add CD for mmc1
> + 7d64f765630a2921a63b82f93f9959a6de37f29d ARM: dts: am335x-boneblack: add eMMC DT entry
> + dc96cd4003e2668d8ec7e7fe19e402e97a198f81 ARM: dts: am335x-bone-common: switch mmc1 to 4-bit mode
> + f8262e78830cda56c936724549ba9f04dddde312 ARM: dts: am335x-bone-common: add cpu0 and mmc1 triggers
>
> Also available as a git branch at https://github.com/koenkooi/linux/commits/mainline

FWIW, tested this branch on BB black/white with MMC rootfs.

Tested-by: Kevin Hilman <khilman@linaro.org>

Koen, Thanks for your persistence getting this stuff merged.

Kevin

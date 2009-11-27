From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 27 Nov 2009 13:47:08 +0100
Subject: ARM: pxa: add support for Raumfeld audio devices [v3]
Message-ID: <1259326031-8856-1-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is spin #3 for these patches which has Eric's and Mark's latest
comments addressed:

- fixed audio regulators went from the ASoC code to arch/arm
- GPIO defines are now pure numbers, usage of mfp_to_gpio() removed
- mfp tables are now __initdata
- CONFIG_PXA3XX_GCU removed for now

Thanks,
Daniel

[PATCH 1/3] ARM: pxa/raumfeld: add platform support
[PATCH 2/3] ALSA: ARM: add Raumfeld audio support
[PATCH 3/3] ARM: pxa/raumfeld: Add defconfig

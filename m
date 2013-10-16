From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Oct 2013 12:04:05 +0100
Subject: at91sam9g20-ek pinctrl conflicts
Message-ID: <20131016110405.GH2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Booting an at91sam9g20-ek I see errors loading the MMC driver due to
conflicts with SPI:

pinctrl-at91 pinctrl.2: pin pioA1 already requested by fffc8000.spi; cannot claim for fffa8000.mmc
pinctrl-at91 pinctrl.2: pin-1 (fffa8000.mmc) status -22
pinctrl-at91 pinctrl.2: could not request pin 1 (pioA1) from group mmc0_slot1_cmd_dat0-0  on device pinctrl.2

One of the devices seems to be configured incorrectly here but I don't
have schematics so it's not immediately obvious which.

Thanks,
Mark
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131016/4682f89b/attachment-0001.sig>

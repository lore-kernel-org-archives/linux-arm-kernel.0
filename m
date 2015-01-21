From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 21 Jan 2015 09:26:22 +0100
Subject: [PATCH 8/8] regulator: MT6397: Add support for MT6397 regulator
In-Reply-To: <1421747231-554-9-git-send-email-s.hauer@pengutronix.de>
References: <1421747231-554-1-git-send-email-s.hauer@pengutronix.de>
 <1421747231-554-9-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150121082622.GG18908@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 10:47:11AM +0100, Sascha Hauer wrote:
> From: Flora Fu <flora.fu@mediatek.com>
> 
> This adds support for the regulators on the MediaTek MT6397
> Multifunction device.
> 
> Signed-off-by: Flora Fu, MediaTek
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt   |  41 ++-
>  .../bindings/regulator/mt6397-regulator.txt        | 217 ++++++++++++++
>  drivers/regulator/Kconfig                          |   9 +
>  drivers/regulator/Makefile                         |   1 +
>  drivers/regulator/mt6397-regulator.c               | 332 +++++++++++++++++++++
>  include/linux/regulator/mt6397-regulator.h         |  49 +++
>  6 files changed, 626 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
>  create mode 100644 drivers/regulator/mt6397-regulator.c
>  create mode 100644 include/linux/regulator/mt6397-regulator.h
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt

I'll move this documentation update to the patch adding the MFD driver
where it belongs to. I'll drop the reset of this patch since it's already
in Linux-next.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

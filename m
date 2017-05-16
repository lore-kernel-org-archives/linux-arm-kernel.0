From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 16 May 2017 10:58:30 -0300
Subject: imx7: mmc_select_hs200 failed, error -74
Message-ID: <CAOMZO5ByTR1C4qUdc+hBcGTFVf-NH2gS5PmH3=w5-TrAoDQVUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On a imx7s-warp board (sdhci-esdhc-imx.c driver) running 4.12-rc1 the
following mmc1 error message is seen:

[    1.796192] mmc1: mmc_select_hs200 failed, error -74
[    1.810220] mmc1: new MMC card at address 0001
[    1.823066] mmcblk1: mmc1:0001 V10008 7.05 GiB
[    1.834155] mmcblk1boot0: mmc1:0001 V10008 partition 1 4.00 MiB
[    1.841608] mmcblk1boot1: mmc1:0001 V10008 partition 2 4.00 MiB
[    1.848971] mmcblk1rpmb: mmc1:0001 V10008 partition 3 4.00 MiB
[    1.859576]  mmcblk1: p1 p2

The rootfs can be mounted correctly from eMMC though.

What is the proper way to fix the 'mmc_select_hs200 failed' error message?

Thanks,

Fabio Estevam

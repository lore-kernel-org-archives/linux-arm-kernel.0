From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 10 Mar 2018 13:46:30 -0300
Subject: PSCI version misdetection
Message-ID: <CAOMZO5BbxFTfD_ZsL5zVhHU5Ue_J_YGBW35AwNx=PVpu6WsqwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On a  imx7d-sdb board running 4.14-rc6:

[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv65535.65535 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.

The PSCI version seems to be misdetected.

CONFIG_ARMV7_PSCI_1_0 is passed in U-Boot, so I would expect to see:

psci: PSCIv1.0 detected in firmware.

Any ideas?

Thanks

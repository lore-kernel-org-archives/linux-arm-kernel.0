From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 11 Mar 2018 15:37:06 -0300
Subject: PSCI version misdetection
In-Reply-To: <CAOMZO5BbxFTfD_ZsL5zVhHU5Ue_J_YGBW35AwNx=PVpu6WsqwQ@mail.gmail.com>
References: <CAOMZO5BbxFTfD_ZsL5zVhHU5Ue_J_YGBW35AwNx=PVpu6WsqwQ@mail.gmail.com>
Message-ID: <CAOMZO5B1sGECGRAtaYwuV9xeDkAXSv0iqPJeopJ_JEtFAOaM-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 10, 2018 at 1:46 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi,
>
> On a  imx7d-sdb board running 4.14-rc6:

I meant 4.14-rc4 :-)

>
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv65535.65535 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: MIGRATE_INFO_TYPE not supported.
>
> The PSCI version seems to be misdetected.
>
> CONFIG_ARMV7_PSCI_1_0 is passed in U-Boot, so I would expect to see:
>
> psci: PSCIv1.0 detected in firmware.
>
> Any ideas?
>
> Thanks

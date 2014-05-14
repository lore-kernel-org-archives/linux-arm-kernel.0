From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Wed, 14 May 2014 10:37:47 +0000
Subject: Freescale FEC i.MX28 VLAN support?
In-Reply-To: <5373418F.6090602@meduna.org>
References: <5373418F.6090602@meduna.org>
Message-ID: <af16d562c5674929a5d12f0625a5685a@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stano,

From: Stanislav Meduna <stano@meduna.org> Data: Wednesday, May 14, 2014 6:13 PM
>To: linux-kernel at vger.kernel.org; netdev at vger.kernel.org; Linux ARM Kernel
>Subject: Freescale FEC i.MX28 VLAN support?
>
>Hi,
>
>is there any particular reason why the FEC_QUIRK_HAS_VLAN is only set for imx6q-
>fec ?
>
>According to the reference manual the VLAN support is also present in i.MX28 and
>the DMA descriptors look the same in this regard, but this is from eyeballing only,
>I did not try to play with it yet.
>
>The reason I am asking is that I am using a switch that can tag the frames
>according to the port a packet is received from/sent to and I would like to use
>that feature.
>
>Please Cc: me when replying.
>
>Thanks
>--
>                                Stano

Imx28 also support the feature, you can enable it.
HW only support detect VLAN packet. The function with the config just using software to remove VLAN tag while receiving one packet.

Thanks,
Andy

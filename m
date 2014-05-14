From: stano@meduna.org (Stanislav Meduna)
Date: Wed, 14 May 2014 12:12:31 +0200
Subject: Freescale FEC i.MX28 VLAN support?
Message-ID: <5373418F.6090602@meduna.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

is there any particular reason why the FEC_QUIRK_HAS_VLAN
is only set for imx6q-fec ?

According to the reference manual the VLAN support is also
present in i.MX28 and the DMA descriptors look the same
in this regard, but this is from eyeballing only, I did not
try to play with it yet.

The reason I am asking is that I am using a switch that can
tag the frames according to the port a packet is received
from/sent to and I would like to use that feature.

Please Cc: me when replying.

Thanks
-- 
                                Stano

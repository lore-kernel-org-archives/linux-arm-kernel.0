From: mhei@heimpold.de (Michael Heimpold)
Date: Tue, 24 Jan 2017 06:44:55 +0000
Subject: [PATCH v2 0/9] ARM: dts: support I2SE Duckbill devices
In-Reply-To: <CAOMZO5CbPPR7GSjUvPQaHGCTTiFw8PrQfiwa_j2x9+WyKuseZg@mail.gmail.com>
References: <1485123764-14754-1-git-send-email-mhei@heimpold.de>
 <CAOMZO5CbPPR7GSjUvPQaHGCTTiFw8PrQfiwa_j2x9+WyKuseZg@mail.gmail.com>
Message-ID: <20170124064455.Horde.BVd2TVghMJl52nkc24d9p40@www.mhei.heimpold.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Zitat von Fabio Estevam <festevam@gmail.com>:

> Hi Michael,
>
> On Sun, Jan 22, 2017 at 8:22 PM, Michael Heimpold <mhei@heimpold.de> wrote:
>
>> - Duckbill 485/Duckbill 2 485: as the name implies, these
>>   devices are intended to be used as Ethernet - RS485 converters
>
> Just curious: do you use mxs-auart to interface to a rs485
> transceiver? If so, would you have mxs-auart patches that add rs485?

Due to the lack of hardware support in mxs-auart for rs485, we decided
to use a more expensive hardware transceiver with auto direction feature.
So the rs485 is (mostly) transparent for upper layers.

Regards,
Michael

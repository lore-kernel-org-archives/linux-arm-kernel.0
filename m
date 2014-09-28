From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Sun, 28 Sep 2014 05:40:37 +0000
Subject: [PATCH v1 3/3] ARM: dts: imx6x: Add enet2 support for imx6sx-sdb
 board
In-Reply-To: <20140928053210.GJ12999@dragon>
References: <1411524680-12863-1-git-send-email-b38611@freescale.com>
 <1411524680-12863-4-git-send-email-b38611@freescale.com>
 <20140928032852.GC12999@dragon>
 <49aafc1f34a34c13ac7af2cf4b04fd6d@BY2PR03MB377.namprd03.prod.outlook.com>
 <20140928034213.GD12999@dragon>
 <7e14fd7a305d44df90bcae3b16b56d60@BY2PR03MB377.namprd03.prod.outlook.com>
 <20140928053210.GJ12999@dragon>
Message-ID: <84ceb11d00654462805551b5172d583f@BY2PR03MB377.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guo Shawn-R65073 Sent: Sunday, September 28, 2014 1:32 PM + 0800
>To: Duan Fugang-B38611
>Cc: linux-arm-kernel at lists.infradead.org; b20596 at solarflare.com;
>shawn.guo at linaro.org; kernel at pengutronix.de
>Subject: Re: [PATCH v1 3/3] ARM: dts: imx6x: Add enet2 support for imx6sx-
>sdb board
>
>On Sun, Sep 28, 2014 at 01:20:16PM +0800, Duan Fugang-B38611 wrote:
>> MX6SX_PAD_ENET2_COL__GPIO2_IO_6: it is a switch which enable ENET_3V3
>and 25Mhz clock for phy.
>> MX6SX_PAD_QSPI1A_DATA0__GPIO4_IO_16: it is a switch which enable
>PERI_3V3 that supply power for some modules including enet MAC and phy.
>>
>
>So it sounds like they can be handled with fixed regulators?
>
>Shawn

It make sense that it use fixed regulators.  I change it for next version.

Thanks,
Andy

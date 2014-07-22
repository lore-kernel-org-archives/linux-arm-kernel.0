From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Tue, 22 Jul 2014 06:58:46 +0000
Subject: [PATCH 2/6] ARM: imx: clk-vf610: add USBPHY clocks
In-Reply-To: <20140722023205.GS8537@dragon>
References: <cover.1405702442.git.stefan@agner.ch>
 <fe660ff42e95a286a954c0560b2b7b2aad81634b.1405702442.git.stefan@agner.ch>
 <20140722023205.GS8537@dragon>
Message-ID: <59acaa7259a54090ab28b037fb412a47@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>-----Original Message-----
>From: Shawn Guo [mailto:shawn.guo at freescale.com]
>Sent: Tuesday, July 22, 2014 10:32 AM
>To: Stefan Agner; Lu Jingchang-B35083
>Cc: Chen Peter-B29397; s.hauer at pengutronix.de; linux-arm-
>kernel at lists.infradead.org; linux-usb at vger.kernel.org; linux-
>kernel at vger.kernel.org
>Subject: Re: [PATCH 2/6] ARM: imx: clk-vf610: add USBPHY clocks
>
>On Fri, Jul 18, 2014 at 07:01:38PM +0200, Stefan Agner wrote:
>> This commit adds PLL7 which is required for USBPHY1. It also adds the
>> USB PHY and USB Controller clocks and the gates to enable them.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>
>Jingchang,
>
>Does the patch look good to you?
>
>Shawn
>
For the clk creation, I think it is ok if the functionality has been tested, thanks!

Acked-by: Jingchang Lu <jingchang.lu@freescale.com>

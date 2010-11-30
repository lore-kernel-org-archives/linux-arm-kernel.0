From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 30 Nov 2010 12:44:27 -0200
Subject: [PATCH v2 1/2] ARM: mx5: dynamically allocate pwm devices
In-Reply-To: <20101130143837.GK20449@pengutronix.de>
References: <1291118521-11385-1-git-send-email-fabio.estevam@freescale.com>
	<20101130143837.GK20449@pengutronix.de>
Message-ID: <4CF50DCB.5090808@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
On 11/30/2010 12:38 PM, Uwe Kleine-K?nig wrote:
> Hello Fabio,
>
> both patches look ok. (Yes, that's an Acked-by: me for both)
>
> Uwe

I am working on v3 as I realized I forgot to remove the keypad entries 
from devices.c and devices.h and also to use register keypad dynamically 
for 2 boards (eukrea_mbimx51-baseboard and board-mx51_3ds.c).

Will submit it soon.

Thanks,

Fabio Estevam

From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 29 Nov 2010 20:27:21 -0200
Subject: [PATCH] imx: dma: remove SDMA_IS_MERGED
In-Reply-To: <20101129212446.GB6017@pengutronix.de>
References: <1290626971-14863-1-git-send-email-fabio.estevam@freescale.com>
	<20101124194439.GY4693@pengutronix.de>
	<AANLkTingtkuvLE9TMxM5f=uwgK95Wfw8kPyXa_NxekEZ@mail.gmail.com>
	<20101124201831.GZ4693@pengutronix.de>
	<AANLkTi=BXLAOVxTbUerDVisHy9FHFV-YcXu1LN9GHN_h@mail.gmail.com>
	<20101125091346.GS6017@pengutronix.de>
	<AANLkTi=L_5ib-Kj0fZRci7-bPOpkyojejZ9+jZpmH9aC@mail.gmail.com>
	<20101129212446.GB6017@pengutronix.de>
Message-ID: <AANLkTik6CScZ5uL2s_qf9q5w6i13mBk_0CLkLZHCKwSm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Nov 29, 2010 at 7:24 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
....
>> I also generated the SDMA firmware (sdma-imx51-to1.bin) via your sdma
>> tool and placed it under /lib/firmware, but the result is the same
>> with or without a valid firmware: when request_firmware is called the
>> following crash happens:
>
> I tried to reproduce this today. Instead of crashing my kernel simply
> hangs. This seems to be because request_firmware waits till the firmware
> appears which never happens. I remember a crash like this though, I
> think it has something to do with the firmware related kconfig options.
> I hope to find a time slot later this week to track this down.

Could you please share your .config?

I would like to compare what may be causing the different behaviours
we are seeing.

Thanks,

Fabio Estevam

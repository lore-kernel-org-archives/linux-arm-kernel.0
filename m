From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 2 Dec 2010 13:36:15 -0200
Subject: [PATCH] imx: dma: remove SDMA_IS_MERGED
In-Reply-To: <20101202121400.GH6017@pengutronix.de>
References: <20101124201831.GZ4693@pengutronix.de>
	<AANLkTi=BXLAOVxTbUerDVisHy9FHFV-YcXu1LN9GHN_h@mail.gmail.com>
	<20101125091346.GS6017@pengutronix.de>
	<AANLkTi=L_5ib-Kj0fZRci7-bPOpkyojejZ9+jZpmH9aC@mail.gmail.com>
	<20101129212446.GB6017@pengutronix.de>
	<AANLkTik6CScZ5uL2s_qf9q5w6i13mBk_0CLkLZHCKwSm@mail.gmail.com>
	<20101201111448.GF6017@pengutronix.de>
	<878w09u3nu.fsf@lechat.rtp-net.org>
	<20101201154128.GG6017@pengutronix.de>
	<87wrntrrc2.fsf@lechat.rtp-net.org>
	<20101202121400.GH6017@pengutronix.de>
Message-ID: <AANLkTincSeqA79xbKJv5sWFbR7r79zSpbu1CT6H12tyU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 2, 2010 at 10:14 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
...
>> what about to2 ?
>
> Someone from Freescale (I think it was Yong) said to me 'if you find a
> board with an i.MX51 older than to3 outside of Freescale, just throw it
> away'. I don't know which SDMA code we have to use for to2.

MX51TO2 and MX51TO3 use the same SDMA firmware.

Regards,

Fabio Estevam

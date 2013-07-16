From: b32955@freescale.com (Huang Shijie)
Date: Tue, 16 Jul 2013 16:11:19 +0800
Subject: [PATCH 2/3] serial: mxs: enable the DMA only when the rts/cts
 is enabled
In-Reply-To: <20130716073305.GP12139@pengutronix.de>
References: <1373857736-30108-1-git-send-email-b32955@freescale.com>
 <1373857736-30108-2-git-send-email-b32955@freescale.com>
 <20130715082716.GM12139@pengutronix.de> <51E3B5B5.1030706@freescale.com>
 <20130715090755.GN12139@pengutronix.de> <51E3D499.3060902@freescale.com>
 <20130716073305.GP12139@pengutronix.de>
Message-ID: <51E50027.4020701@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?07?16? 15:33, Uwe Kleine-K?nig ??:
>> This patch depends on the first patch. :)
> But it's not a hard dependency.
>
do you mean i should merge the patch 1 and patch 2 into a single patch?

>>> Something like:
>>>
>>> 	serial: mxs-auart: DMA unreliable without RTS/CTS
>>>
>>> 	According to [add some document name here] DMA doesn't work
>>> 	reliable without hardware handshaking. So make DMA dependant on
>>>   
>> Please see the spec about the RTSEN and RTS.
> Right, it's not hard for me. Other might not have the manual handy, so
> a comment telling:
>
>> RTSEN enable the flow control by the hardware;
>> RTS enable the flow control by the software.
> would be nice.
i think we need another patch to add this comment.

thanks
Huang Shijie

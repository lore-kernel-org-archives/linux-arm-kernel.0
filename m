From: r.sricharan@ti.com (Sricharan R)
Date: Fri, 11 Mar 2011 11:43:03 +0530
Subject: [PATCH] omap2+: mux: Add macro for configuring static with
	omap_hwmod_mux_init (Re: [PATCH] omap2+: mux: Remove the use of IDLE
	flag)
In-Reply-To: 48ce1c025ceaf65d610ce5eaa6ea99e4@mail.gmail.com
References: <1299472552-22017-1-git-send-email-r.sricharan@ti.com>
	<20110308164033.GC26463@atomide.com>
	<b76e32aff88265d31cc1b7b2fc502a32@mail.gmail.com>
	<20110309203200.GP26463@atomide.com>
	48ce1c025ceaf65d610ce5eaa6ea99e4@mail.gmail.com
Message-ID: <d613e06b28e16ab8da53af60e1e2ec56@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,
>>Look OK to me, but let's make things a bit easier to read
>>and maintain with the following patch. Can you please
>>update your patches to use this macro?
>>
>>Each line then just becomes something like:
>>
>>OMAP_MUX_STATIC("uart3_tx_irtx.uart3_tx_irtx",
>>		OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
>>
>Ok thanks. I will update and send again.

4430SDP:
http://marc.info/?l=linux-omap&m=129982347622340&w=2

omap4panda:
http://marc.info/?l=linux-omap&m=129982347722344&w=2

3430sdp:
http://marc.info/?l=linux-omap&m=129982347822347&w=2

I have reworked the patches using your MACRO.

I have applied on top of the omap-for-linus branch and
tested them on 4430sdp, 3430sdp, omap4panda.

Thanks,
 Sricharan'

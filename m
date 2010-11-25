From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 25 Nov 2010 10:32:59 -0200
Subject: [PATCH] imx: dma: remove SDMA_IS_MERGED
In-Reply-To: <87tyj5wpqt.fsf@lechat.rtp-net.org>
References: <1290626971-14863-1-git-send-email-fabio.estevam@freescale.com>
	<20101124194439.GY4693@pengutronix.de>
	<AANLkTingtkuvLE9TMxM5f=uwgK95Wfw8kPyXa_NxekEZ@mail.gmail.com>
	<20101124201831.GZ4693@pengutronix.de>
	<AANLkTi=BXLAOVxTbUerDVisHy9FHFV-YcXu1LN9GHN_h@mail.gmail.com>
	<20101125091346.GS6017@pengutronix.de>
	<AANLkTi=L_5ib-Kj0fZRci7-bPOpkyojejZ9+jZpmH9aC@mail.gmail.com>
	<87tyj5wpqt.fsf@lechat.rtp-net.org>
Message-ID: <AANLkTi=hwzdkzpZNdi7raXUwAJQB1Apwok-wT04a0EwZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

On Thu, Nov 25, 2010 at 10:29 AM, Arnaud Patard
<arnaud.patard@rtp-net.org> wrote:
> Fabio Estevam <festevam@gmail.com> writes:
...
> I've tried some weeks ago to boot with sdma support enabled and found
> out that it was looking for sdma-imx51-to0.bin so I thought it was still
> early work and gave up. Maybe it's still not fixed.

Yes, I fixed this by passing the correct tape-out version into the
sdma platform, so that it searches for sdma-imx51-to1.bin now.

I can send a patch for this later.
....
>> I am trying to fix this, but suggestions are welcome.
>
> Even if the fw name is bad, it should not crash. Maybe missing some
> checks or init code ? Of course, it's only an idea. Your problem may
> have nothing to do with missing firmware.

Yes, this crash problem is not related to the missing firmware.

Thanks,

Fabio Estevam

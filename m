From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Fri, 03 Dec 2010 14:00:47 +0100
Subject: [PATCH] imx: dma: remove SDMA_IS_MERGED
In-Reply-To: <AANLkTimofVgY4M7U+aLA1RUz0a2LOmPUFr6bwcj1vcZw@mail.gmail.com>
	(Fabio Estevam's message of "Wed, 1 Dec 2010 13:40:17 -0200")
References: <1290626971-14863-1-git-send-email-fabio.estevam@freescale.com>
	<20101124194439.GY4693@pengutronix.de>
	<AANLkTingtkuvLE9TMxM5f=uwgK95Wfw8kPyXa_NxekEZ@mail.gmail.com>
	<20101124201831.GZ4693@pengutronix.de>
	<AANLkTi=BXLAOVxTbUerDVisHy9FHFV-YcXu1LN9GHN_h@mail.gmail.com>
	<20101125091346.GS6017@pengutronix.de>
	<AANLkTi=L_5ib-Kj0fZRci7-bPOpkyojejZ9+jZpmH9aC@mail.gmail.com>
	<20101129212446.GB6017@pengutronix.de>
	<AANLkTik6CScZ5uL2s_qf9q5w6i13mBk_0CLkLZHCKwSm@mail.gmail.com>
	<20101201111448.GF6017@pengutronix.de>
	<AANLkTimofVgY4M7U+aLA1RUz0a2LOmPUFr6bwcj1vcZw@mail.gmail.com>
Message-ID: <87zksnovsw.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio Estevam <festevam@gmail.com> writes:

Hi,

[...]

>> It would be great if someone steps forward and mainlines this sgtl5000
>> codec driver, that's currently the main showstopper for sound support on
>> the Freescale boards.
>
> Thanks a lot for setting up this branch. I can confirm that audio
> works on MX51 Babbage on this branch.
>
> I will check internally if someone is willing to mainline sgtl5000.

If you find no vic^H^H^Hvolunteer, I'll look at it. Looks like the
sgtl5000 chipset is not very complicated.

Arnaud

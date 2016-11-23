From: kvalo@codeaurora.org (Kalle Valo)
Date: Wed, 23 Nov 2016 21:26:42 +0200
Subject: ath9k ARMv7 OOPS in v4.8.6, v4.2.8
In-Reply-To: <20161123191539.GF2799@io.lakedaemon.net> (Jason Cooper's message
 of "Wed, 23 Nov 2016 19:15:39 +0000")
References: <20161123191539.GF2799@io.lakedaemon.net>
Message-ID: <87a8cqgfpp.fsf@kamboji.qca.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason Cooper <jason@lakedaemon.net> writes:

> All,
>
> I have a Ubiquiti SR-71 mini-pcie ath9k card in a Globalscale Mirabox
> board (Marvell Armada 370 SoC).  Every day or so I get a consistent
> crash that brings down the whole board.  I've attached three oops I
> captured on the serial port.
>
> I looked at the commits from v4.8.6 to v4.9-rc6, and nothing jumped out
> at me as "this would fix it".  And since it takes a day or so to trigger
> the oops, bisecting would be a bit brutal.  Does anyone have any insight
> into this?

Is this a regression, meaning that it didn't crash on older kernels but
crashes on newer ones? Or has it always crashed?

-- 
Kalle Valo

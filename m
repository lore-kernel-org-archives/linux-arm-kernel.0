From: dongas86@gmail.com (Dong Aisheng)
Date: Sat, 16 Jul 2011 01:22:16 +0800
Subject: [alsa-devel] [PATCH V2 06/10] ARM: mxs: add saif device
In-Reply-To: <20110715153450.GA31640@pengutronix.de>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-7-git-send-email-b29396@freescale.com>
	<20110715133241.GG2021@pengutronix.de>
	<CAA+hA=TtBrDoAMfv0fqj30_heEJuZJFH=QjTUG8zTys0G+vgvA@mail.gmail.com>
	<20110715153450.GA31640@pengutronix.de>
Message-ID: <CAA+hA=RSXQJ1QhSMrdkxhpDvAwib-HDxO7wOQ6-XOOVgBq9hyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/15 Wolfram Sang <w.sang@pengutronix.de>:
> If you just do playback, do you need to mux SAIF1-clk to SAIF0-clk ? If not
> (what I'd think), just leave changing DIGCTL out completely since the
> reset-default for that register should work. If you do need changing DIGCTL,
> some helper function like mentioned above would be better, I think.

You're right.
I will remove that line of code firstly before doing record and we will provide
that helper funtion later.
Thanks for your suggestions.

Regards
Dong Aisheng

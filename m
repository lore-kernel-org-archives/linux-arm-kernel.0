From: avictor.za@gmail.com (Andrew Victor)
Date: Mon, 19 Oct 2009 23:13:40 +0200
Subject: [PATCH] at91: support for eco920
In-Reply-To: <20091019074729.GA11449@pengutronix.de>
References: <1255378294-10913-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<cd73a99e0910181325i65632137w5250868755fbeb98@mail.gmail.com>
	<20091019074729.GA11449@pengutronix.de>
Message-ID: <cd73a99e0910191413u2fdaf269tcef50a38839e1f6f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

>> Yes, each AT91-based board usually has its own defconfig.
> Should I add one for that board? ?I'd like to have it enabled in a
> defconfig, but I'd prefer to simply enable it in an already existing one
> and so don't increase the number of defconfigs.
>
> Thoughts?

Well, the config file says what external peripherals are available on
the board (and therefore what drivers to enable).  So it is kind of
unique to the board.

But if you really don't want to add another defconfig (but want it
included in a defconfig), you can probably add it to the AT91RM9200-DK
one.  (I don't think many people are still using that board, but I
still always compile-test that one).


Regards,
  Andrew Victor

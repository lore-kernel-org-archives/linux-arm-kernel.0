From: avictor.za@gmail.com (Andrew Victor)
Date: Sun, 8 Apr 2012 23:55:22 +0200
Subject: [PATCH RFC] ARM: at91: remove at91_register_uart_fns and headers
In-Reply-To: <CAF8ieYVvWJDEkVheGrCuQ+4Ucx_WV-M3qXia1-Y97vqCmeeETQ@mail.gmail.com>
References: <1333728149-32711-1-git-send-email-joachim.eastwood@jotron.com>
 <20120408180906.GA13348@samfundet.no>
 <CAF8ieYVvWJDEkVheGrCuQ+4Ucx_WV-M3qXia1-Y97vqCmeeETQ@mail.gmail.com>
Message-ID: <CAFumwP38ghv91gwZ55pQeDDD67_t+61pLqBkvX8wzZk5R-3z5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

> Yeah, as far as I know, nobody ever used this functionality on AVR32.
> In fact, I can't even think of a reason to use it.
>
> But I seem to recall submitting a patch to remove this functionality a
> long time ago, and it was struck down. I don't remember the reason,
> but there's a chance it might still be valid.

Some of the SAN People / Multenet AT91RM9200 boards needed it....
We needed to use GPIO pins for some of the modem-control signals -
couldn't use the standard pins since the alternate pin function was
being used.


Regards,
 Andrew Victor

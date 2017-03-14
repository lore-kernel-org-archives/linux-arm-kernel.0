From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Mar 2017 16:32:00 +0100
Subject: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
In-Reply-To: <20170306100220.droey65uq2ew3mzu@pengutronix.de>
References: <20170303191248.wlwjri55ip2x5pgg@pengutronix.de>
 <CAMuHMdXFrwa2jCVDb+8ecqgARLG0oGrPp9pLs0b6vEiWeKJ+uA@mail.gmail.com>
 <20170303194414.n76tr3oa2mlrzjre@pengutronix.de>
 <CAMuHMdXiz5hqW=fm-2H1aNKq_gXD2o0508jD2XjxYUvKoEvHdw@mail.gmail.com>
 <20170304174819.esxhwwbsxzuq3vyc@pengutronix.de>
 <CAMuHMdX8BEnaTtNFAbcvfHwJH=oPUmQ2NB+jfouGyhQpJ_m_4A@mail.gmail.com>
 <20170306085842.yijkfpqi3adcedmm@pengutronix.de>
 <CAMuHMdV2_vbocY4wCzvYtPAaF+QEX_Y4g6qVu5EqEBf5AnFdaw@mail.gmail.com>
 <20170306093043.ay4dz3ehp3aakwxh@pengutronix.de>
 <CAMuHMdWQuvANNU14A7NQuzv6AFp04bq4DG_oc7w9h4wUrG+4aQ@mail.gmail.com>
 <20170306100220.droey65uq2ew3mzu@pengutronix.de>
Message-ID: <CACRpkdZyey3jyApevpe1tDyFdPut0J+7ZeiyJQgdaWJLr09mrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 6, 2017 at 11:02 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

>> Anyway, for sh-sci.c, platforms either have DT and GPIOLIB, or they do not
>> need mctrl-gpio.
>
> So we're in agreement now that HALFGPIOLIB is the way to go?
> Linus, what do you think?

I'm too swamped in mail and work to figure this out right now. I guess
I will get back to it...

I need more active comaintainers I guess, interested in the job? ;)

Yours,
Linus Walleij

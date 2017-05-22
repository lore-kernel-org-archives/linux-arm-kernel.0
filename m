From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 May 2017 17:54:58 +0200
Subject: [PATCH] ARM: dts: imx28: add gpio-ranges for internal gpio
 controller
In-Reply-To: <20170515071608.auju66dhylzaexkw@pengutronix.de>
References: <20170508085925.18342-1-u.kleine-koenig@pengutronix.de>
 <20170511075135.GF5833@dragon>
 <20170511080916.gim5pyhj5jarzf4r@pengutronix.de>
 <20170512030536.GC8471@dragon>
 <20170512080150.uh5qmwu2tctpd6jk@pengutronix.de>
 <20170515022129.GJ8471@dragon>
 <20170515071608.auju66dhylzaexkw@pengutronix.de>
Message-ID: <CACRpkdYvQdDXfK5QkWM6x6F4+UEQ=4oX_1gqdbjkk9n7tM5FSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 9:16 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Mon, May 15, 2017 at 10:21:30AM +0800, Shawn Guo wrote:

>> You will need to free the GPIO before muxing it to a different function,
>> I think.
>
> IMHO this is a bad concept. This makes GPIOs more special than for
> example PWMs or LEDs. And it breaks some configurations (for example the
> make-pins-highz-on-idle setup in my previous mails).

So this is the reason why pin controllers can choose to be strict
or not: people disagree on the semantics.

But it's good if the driver maintainers agree for a certain driver :D

Yours,
Linus Walleij

From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 27 May 2015 12:25:41 -0400 (EDT)
Subject: [PATCH RFC] ARM: use -marm unconditionally for THUMB2_KERNEL=n
 builds
In-Reply-To: <1432719727-28860-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1432719727-28860-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <alpine.LFD.2.11.1505271222090.13042@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 May 2015, Uwe Kleine-K?nig wrote:

> Arnd told me on irc that Nico did some build tests with ancient
> compilers some time ago. Maybe you can tell which was the first compiler
> to support -marm?

I didn't go beyond gcc 4.0.2. This is not going to help you much.


Nicolas

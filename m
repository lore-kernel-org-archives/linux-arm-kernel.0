From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Jun 2011 21:13:44 +0200
Subject: [PATCH 1/3] leds: create a trigger for ARM CPU activity
In-Reply-To: <alpine.LFD.2.00.1106221446350.2142@xanadu.home>
References: <1308763983-24749-1-git-send-email-linus.walleij@stericsson.com>
	<alpine.LFD.2.00.1106221446350.2142@xanadu.home>
Message-ID: <BANLkTimg7g4G+N1ADW5GM+ymxZP12ROZxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 9:06 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:

> Looks nice to me. ?You don't handle the led_timer event, but since there
> is already a ledtrig-heartbeat trigger available, the conversion to the
> generic LED API can use that by default.

Yep LED0 by default is heartbeat on RealView and Versatile with
new LEDs. And I also took LED1 for MMC activity.

So this should be the final piece.

> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Thanks!

> Converting all remaining users of leds_event would be a great thing too.

I looked briefly at Integrator, I have a piece of that hardware actually
but there doesn't seem to be an archaeologist around to help me
boot it :-/

Linus Walleij

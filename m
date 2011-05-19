From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 19 May 2011 09:26:14 +0200
Subject: [patch 5/7] clockevents: Provide interface to reconfigure an
	active clock event device
In-Reply-To: <20110518210136.437459958@linutronix.de>
References: <20110518205713.947614271@linutronix.de>
	<20110518210136.437459958@linutronix.de>
Message-ID: <BANLkTimhg6WAErYPSaSagZUc0mRZdNREvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/18 Thomas Gleixner <tglx@linutronix.de>:

> Some ARM SoCs have clock event devices which have their frequency
> modified due to frequency scaling. Provide an interface which allows
> to reconfigure an active device. After reconfiguration reprogram the
> current pending event.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for fixing this much needed function Thomas!
Linus Walleij

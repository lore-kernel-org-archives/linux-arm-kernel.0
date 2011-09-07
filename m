From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 7 Sep 2011 12:05:30 +0200 (CEST)
Subject: [PATCH 4/4] mach-integrator: get timer frequency from clock
In-Reply-To: <1315384293-27438-1-git-send-email-linus.walleij@stericsson.com>
References: <1315384293-27438-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <alpine.LFD.2.02.1109071204530.2723@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Sep 2011, Linus Walleij wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
> 
> We already have a clock definition for the 24MHz clock in
> the Integrator, use that instead of some unclear defines
> from the platform.h header. Also delete the senseless
> comment that the file shouldn't be edited, I just edited it
> and the world didn't come to an end, so it's obviously

:)

> false. If anyone still has the mentioned ".s file" and the
> s2h awk script generating that header, raise your hand
> (and give me your files).
> 
> Cc: Russell King <linux@arm.linux.org.uk>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

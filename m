From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 18 Jul 2011 17:40:52 +0200
Subject: linux-next regression on ARM926
In-Reply-To: <20110718112757.GV23270@n2100.arm.linux.org.uk>
References: <CACRpkdbBrVda2oD42tjrWiG6uHXAdWwpr6cZ7qnSc2KM82XCfw@mail.gmail.com>
	<20110718112757.GV23270@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYFPfY+UDJoWaa6g=tDo=y1_3SKhMCnKPNsKn8xmF-JAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2011 at 1:27 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> One solution would be to put an #ifdef CONFIG_PM_SLEEP around that in
> mm/proc-macros.S to select .word 0 instead, and get rid of the #else
> in the individual proc-*.S files - something like this (untested):

It works like a charm for U300. Thanks Russell!
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

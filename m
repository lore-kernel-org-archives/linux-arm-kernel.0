From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 1 Apr 2012 18:44:58 +0200
Subject: [PATCH] serial: fix pl011 probe
In-Reply-To: <alpine.LFD.2.02.1204011120000.24151@xanadu.home>
References: <alpine.LFD.2.02.1204011120000.24151@xanadu.home>
Message-ID: <CACRpkdbu+ysxMnx7F7aRoGZ=t9Q_Mb3uAWM7+-2Vh4vTVsEuoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 1, 2012 at 5:39 PM, Nicolas Pitre <nico@fluxnic.net> wrote:

> Commit 9b96fbacda "serial: PL011: clear pending interrupts" (which is
> also marked with Cc: stable <stable@vger.kernel.org>) oopses the kernel
> as it uses an unitialized uap->port.membase.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Yes mea culpa.

However I sent a fix-up patch "serial: PL011: move interrupt clearing"
March 21st, we're just waiting for Greg to pick it up...

Yours,
Linus Walleij

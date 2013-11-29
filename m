From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Nov 2013 13:11:08 +0100
Subject: STOP THE MADNESS
In-Reply-To: <20131129104614.GW16735@n2100.arm.linux.org.uk>
References: <20131126163031.GC16735@n2100.arm.linux.org.uk>
 <20131129020149.GU16735@n2100.arm.linux.org.uk>
 <CACRpkdao9ct-fKaUnrdX=dmN+fyuVgcbWQvc_sZTwp8wGdJ0+A@mail.gmail.com>
 <20131129104614.GW16735@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdacfWdpHTm9wcRj7Dg2r24gCasc5z1EYoC2foJjR9+uRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 11:46 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Note that the GPIO bug should show on anything due to the nature of it -
> it's probably the debug options which mostly show it.  Making sure you
> have spinlock debugging and lockdep enabled.

Yep I noticed ... when developing the fix yesterday I poisoned the
spinlock explicitly to provoke the error and after doing that and
sending the fix I realized that it was probably provoked by spinlock
debug (which I usually run, don't know what was wrong with me).

Anyway the fix should be somewhere in your inbox.

Yours,
Linus Walleij

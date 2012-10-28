From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 28 Oct 2012 19:34:03 +0100
Subject: [PATCH RESEND] ARM: pxa27x_keypad: clear pending interrupts on
 keypad config
In-Reply-To: <CA+E=qVeETyX+jY+uKS5HAOymGOnF7x+sKGnmrQ0J=3CbnfVTNg@mail.gmail.com>
 (Vasily Khoruzhick's message of "Sun, 28 Oct 2012 21:09:42 +0300")
References: <1351439163-9575-1-git-send-email-anarsoul@gmail.com>
 <87vcduwkfa.fsf@free.fr>
 <CA+E=qVeETyX+jY+uKS5HAOymGOnF7x+sKGnmrQ0J=3CbnfVTNg@mail.gmail.com>
Message-ID: <87r4oiwin8.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vasily Khoruzhick <anarsoul@gmail.com> writes:

> It behaves correctly, it just can't handle last keypress (because it's
> booting Linux).
> Even if it would be possible to fix this issue in bootloader it's
> always nice to keep driver
> failure-proof, so it does not fail even if bootloader left something
> in non-consistent state.
True.
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert

From: olof@lixom.net (Olof Johansson)
Date: Mon, 27 May 2013 21:22:03 -0700
Subject: [GIT PULL] Nomadik clocks from device tree
In-Reply-To: <CACRpkdaKtxKS0=1UOKJPQWKShRm2nHsUWSK5M+qSR6duXfGrxw@mail.gmail.com>
References: <CACRpkdY8xqi04cf-SJ69QvHr8qB6itqvgxMyNk+=Xrtz2FGVaA@mail.gmail.com>
 <CACRpkdaKtxKS0=1UOKJPQWKShRm2nHsUWSK5M+qSR6duXfGrxw@mail.gmail.com>
Message-ID: <20130528042203.GO13532@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 26, 2013 at 10:32:45PM +0200, Linus Walleij wrote:
> Hi ARM SoC people,
> 
> I have accumulated more Nomadik patches so I'm reiterating this
> pull request with two new patches on top.
> 
> Please pull them in for v3.11!

Hi,

I get a merge conflict on this branch with "ARM: nomadik: fix IRQ
assignment for SMC ethernet" from 3.10-rc2.  Fixed it up.

Also:

> Rabin Vincent (1):
>       clocksource: nomadik-mtu: support of probe

Hmm, you're not the first one I've caught having missed to add S-o-b
lines on patches today. Please pay attention to it in the future.

Merged into next/dt for 3.11.


-Olof

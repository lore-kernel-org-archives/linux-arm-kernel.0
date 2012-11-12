From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Nov 2012 14:34:58 +0000
Subject: [GIT PULL] arm-soc: lpc32xx: platform updates
In-Reply-To: <50A0D053.8020602@antcom.de>
References: <509A5992.60009@antcom.de> <50A0D053.8020602@antcom.de>
Message-ID: <201211121434.58468.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 November 2012, Roland Stigge wrote:
> this is a follow-up update of the previous pull request, adding only one patch
> to the LPC32xx platform (Motor PWM clock by Alban Bedel).
> 
> The following changes since commit 91deef8069e7ffafac4467200e1d37af1b2d7c56:
> 
>   ARM: LPC32xx: Cleanup irq.c (2012-11-07 13:30:50 +0100)
> 
> are available in the git repository at:
> 
>   git://git.antcom.de/linux-2.6.git lpc32xx/core
> 

Pulled into next/soc, thanks!

It would be nice if you could start using signed tag for pull requests
and put a little series description into that tag. Ideally signed with
a gpg key that is trusted by other kernel developers, but just having the
changelog is good as well.

	Arnd

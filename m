From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 10 Sep 2011 23:06:58 +0200
Subject: [GIT PULL] at91: changes for next
In-Reply-To: <4E6A09D0.40800@atmel.com>
References: <4E6A09D0.40800@atmel.com>
Message-ID: <201109102306.58340.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 September 2011, Nicolas Ferre wrote:
> Can you please pull the following changes since commit ddf28352b80c86754a6424e3a61e8bdf9213b3c7:
> 
>   Linux 3.1-rc5 (2011-09-04 15:45:10 -0700)
> 
> They are available in the git repository at:
>   git://github.com/at91linux/linux-at91.git  at91-next
> 
> They have been present on linux-arm-kernel for some time and where recently added in linux-next.
> Stephen resolved some trivial conflicts relatives to the removal of a board file (Cf:
> https://lkml.org/lkml/2011/9/9/96 ).
> 
> A series by Thomas is touching the USB subsystem: ohci-at91.c but as most of changes are in the at91 directory, it makes more sense to take them in arm-soc.

Hi Nicolas,

I've resumed pulling patches and uploaded them to git.linaro.org while
master.kernel.org continues to be unavailable.

I've decided to split your branch into two separate branches 'board'
and 'devel' to better match the code from other soc trees in a way
that I can send forward to Linus. Please check that the split trees
actually make sense, and tell me if that's ok for you or if you would
prefer them split differently.

	Arnd

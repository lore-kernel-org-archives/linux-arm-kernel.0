From: olof@lixom.net (Olof Johansson)
Date: Sun, 16 Nov 2014 15:12:44 -0800
Subject: [GIT PULL] at91: fixes for 3.18 #2
In-Reply-To: <1415963482-16582-1-git-send-email-nicolas.ferre@atmel.com>
References: <1415963482-16582-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20141116231244.GD14929@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 12:11:22PM +0100, Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> I don't have more for the moment, so here is trivial at91 material for 3.18.
> 
> Thanks, best regards,
> 
> The following changes since commit 106c67af2fb938880edbf43b49dabbd8d2534839:
> 
>   ARM: at91/dt: sam9263: fix PLLB frequencies (2014-10-22 10:08:22 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes2
> 
> for you to fetch changes up to c4e4bbcee9fa37024a2d4cdcaa5fe89a2c5c7a05:
> 
>   ARM: at91/dt: Fix sama5d3x typos (2014-11-13 12:37:44 +0100)
> 
> ----------------------------------------------------------------
> Tiny typo fixes for this second batch for 3.18
> 
> ----------------------------------------------------------------
> Ludovic Desroches (1):
>       ARM: at91/dt: sama5d4: use macro instead of numeric value

I don't consider this to be a fix at this time in the release, please
include in your 3.19 material.

> Peter Rosin (1):
>       ARM: at91/dt: Fix sama5d3x typos
> 

I did cherry-pick this one in though.

Not sure if I'll make today's -rc with my fixes pull request. :)


-Olof

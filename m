From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Apr 2012 21:57:05 +0000
Subject: [GIT PULL] ux500 GPIO and pins for ARM SoC
In-Reply-To: <1335369929-5856-1-git-send-email-linus.walleij@linaro.org>
References: <1335369929-5856-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201204302157.05288.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 April 2012, Linus Walleij wrote:
> 
> Hi ARM SoC maintainers,
> 
> This is a pull request for the GPIO and pin control stuff
> accumulated in the ST-Ericsson tree. Here we have:
> 
> - Improvements and fixes and a custom pin config API from
>   Rabin Vincent
> 
> - Device Tree bindings from Lee Jones
> 
> - Some accumulated patches by yours truly.
> 
> - A MSP platform data init patch from Ola Lilja that is merged
>   here due to dependency on pin config work. It is to be
>   used with work being worked on in parallel in the ALSA
>   SoC subsystem.
> 
> If you wonder about the custom pin config implementation this
> is to be used as a transition base as I am rewriting the
> driver to use pinctrl. Expect a final pull request on top
> of this one that will move the ux500 over to pinctrl.
> 
> Please pull this in...

Pulled into next/pinctrl branch, thanks!

	Arnd

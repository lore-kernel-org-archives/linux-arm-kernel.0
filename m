From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Apr 2012 21:47:19 +0000
Subject: [GIT PULL] ux500 device tree patches
In-Reply-To: <1335369540-5607-1-git-send-email-linus.walleij@linaro.org>
References: <1335369540-5607-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201204302147.19715.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 April 2012, Linus Walleij wrote:
> this pull request contains some device tree work by Lee Jones.
> I have tried to keep these patches in the arch/arm/boot/dts/*
> space to get some sanity in the branch proliferation.
> 
> There is still one patch that touches arch/arm/mach-ux500 too
> though (but it should merge fine with the other ux500 stuff).
> 
> The changes to the device tree are of course dependent on some
> core changes and some patching in the GPIO/pin driver, but as
> the device tree files are believed to be a different world
> (and should one day live in their own git) I split this off
> anyway. I don't think people bisect the device trees per se
> and the board code in conjunction anyway.
> 
> If you think differently tell me and I'll happily stack
> all three pull requests on top of each other and send one
> big shebang with everything instead :-)
> 
> So: please pull this in.
> 

Pulled, thanks!

	Arnd

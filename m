From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 2 Mar 2012 13:27:23 +0000
Subject: [GIT PULL v2] at91: irqdomain and device tree for 3.4
In-Reply-To: <4F4F8D66.7040205@atmel.com>
References: <4F4F8D66.7040205@atmel.com>
Message-ID: <201203021327.24417.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 March 2012, Nicolas Ferre wrote:
> This pull request supersedes the previous:
> "[GIT PULL] at91: irqdomain and device tree for AIC and GPIO"
> 
> This series adds irqdomain and device tree support for both the
> interrupt and GPIO controllers of AT91 SoC. It has been discussed a lot
> and I think that I have addressed all comments and advices.
> 
> To the AIC, GPIO device tree work, it also adds the the conversion of the 
> PIT and TC timers, the PIO3 support and some basic LED and gpio-keys entries.
> 
> The irqdomain work takes advantage of Grant's patch series that is present
> in:
> git://git.secretlab.ca/git/linux-2.6 irqdomain/next
> This branch is merged into this tree, on top of at91/base2+cleanup (aka cleanup2)
> and before the application of new AT91 material.
> 
> 
> The following changes since commit 89d4a1753b6632327f18d6c8e0842b366b736621:
> 
>   Merge branch 'irqdomain/next' of git://git.secretlab.ca/git/linux-2.6 (2012-03-01 13:26:51 +0100)
 
Pulled into next/dt, looks good!

Thanks,

	Arnd

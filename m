From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Sep 2012 20:27:48 +0000
Subject: [PATCH 11/12] ARM: initial multiplatform support
In-Reply-To: <5050EEA1.5050205@gmail.com>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
 <201209121949.49109.arnd@arndb.de> <5050EEA1.5050205@gmail.com>
Message-ID: <201209122027.48350.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 September 2012, Rob Herring wrote:
> Found this one as well. My fix is to use CONFIG_ARCH_EXYNOS,
> CONFIG_ARCH_SPEAR3XX, etc. instead and remove the multiple lines.
> 
> I want to get this into -next and plan to send you a pull request soon.
> Are you happy with the kconfig parts?

Yes, it all looks good to me. Just doing test builds with your branch
combined with my platform data branch and Marc's smp operations.

I found a few small bugs in my patches as well.

	Arnd

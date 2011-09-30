From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 30 Sep 2011 22:17:13 +0200
Subject: [GIT PULL] at91 fixes for 3.1
In-Reply-To: <4E838F77.2040705@atmel.com>
References: <4E838F77.2040705@atmel.com>
Message-ID: <201109302217.13937.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 September 2011, Nicolas FERRE wrote:
> Here is a couple of fixes that may be included in 3.1-final.
> The Kconfig modification will allow to select the PWM driver for SAM9G45 
> SoC. This will also benefit to stable kernels.
> The new defconfig for SAM9G45 family will allow us to better monitor the 
> health of this port through automatic compilation mechanism. I find it 
> interesting to have it included the sooner.
> 
> The pull is based on the following changes since commit 
> a102a9ece5489e1718cd7543aa079082450ac3a2:
> 
>    Linux 3.1-rc8 (2011-09-27 15:48:34 -0700)
> 
> are available in the git repository at:
>    git://github.com/at91linux/linux-at91.git at91-fixes

Hi Nicolas,

I've pulled them into the fixes branch now. My feeling however is that
these by themselves are not reason enough to send a pull request to Linus,
so they will probably be the first thing I send in the 3.2 merge window,
unless some other important fixes appear.

	Arnd

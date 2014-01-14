From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 14 Jan 2014 15:38:16 -0800
Subject: [GIT PULL] minor Versatile updates
In-Reply-To: <CACRpkdZFDCScea24A=CnV+Yxv-nZGxFKfhQsbvMHbxywwatPsA@mail.gmail.com>
 (Linus Walleij's message of "Wed, 8 Jan 2014 09:00:31 +0100")
References: <CACRpkdZFDCScea24A=CnV+Yxv-nZGxFKfhQsbvMHbxywwatPsA@mail.gmail.com>
Message-ID: <87bnze5e3b.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> Hi ARM SoC folks,
>
> the following is just one minor cleanup and then defconfig changes to
> set the scene for future Versatile cleanup/multiplatform work.
>
> Please pull it in to ARM SoC, the defconfig changes are even post-rc1
> material in some sense.
>
> Yours,
> Linus Walleij
>
>
> The following changes since commit 319e2e3f63c348a9b66db4667efa73178e18b17d:
>
>   Linux 3.13-rc4 (2013-12-15 12:31:33 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> tags/versatile-for-v3.14
>
> for you to fetch changes up to 27d2adb5969eef7ff3bfeb2dc3b2064e3a124952:
>
>   ARM: versatile: enable LEDs by default (2013-12-20 18:22:49 +0100)
>
> ----------------------------------------------------------------
> Versatile patches for v3.14:
>
> - Move GPIO2 and GPIO3 to be registered from the core boardfile.
>
> - Update the defconfig.
>
> Defconfig changes:
>
> - Enable GPIOLIB and PL061 for the Versatile.
>
> - Build the Versatile using EABI.
>
> - Enable the new LEDs in the defconfig.
>
> ----------------------------------------------------------------

Pulled into next/soc.

Thanks,

Kevin

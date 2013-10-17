From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 17 Oct 2013 14:47:34 -0700
Subject: [GIT PULL] Integrator patches for v3.13
In-Reply-To: <CACRpkdbdpJByijRjOZKpEB_5tZt9xro1DLmVXsgrixe9YJTbZg@mail.gmail.com>
 (Linus Walleij's message of "Wed, 16 Oct 2013 14:27:13 +0200")
References: <CACRpkdbdpJByijRjOZKpEB_5tZt9xro1DLmVXsgrixe9YJTbZg@mail.gmail.com>
Message-ID: <87k3hb1seh.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> Hi ARM SoC folks,
>
> this is a second try at an Integrator patch stack for v3.13.
> This addresses the issues reported by Mark Rutland and
> adds two patches on top for some more things he wanted
> me to fix as well.
>
> Further this folds in a defconfig patch and the LED fix.
> The LED fix is DT-related, and the defconfig change is
> related to the LED fix, so they all belong in the same series.
>
> The cpufreq patch is ACKed by both cpufreq maintainers.
>
> Please pull this to some suitable branch in the
> ARM SoC tree.
>
> Yours,
> Linus Walleij
>
> The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:
>
>   Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> tags/integrator-for-v3.13-2
>
> for you to fetch changes up to df36680f1a71eef97685c30eb9eaf55a6813b6cd:
>
>   ARM: integrator: core module registers from compatible strings
> (2013-10-16 14:10:14 +0200)
>
> ----------------------------------------------------------------
> Integrator patches for the v3.13 kernel cycle:
> - Fix up the LED support
> - Update the Integrator defconfig
> - Remove ATAG boot path
> - Move some stuff over to the device tree
>
> ----------------------------------------------------------------

Pulled into next/soc,

Thanks,

Kevin

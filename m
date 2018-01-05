From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Jan 2018 17:58:53 +0100
Subject: [GIT PULL v2 1/2] TI DaVinci SoC support updates for v4.16
In-Reply-To: <20180105145248.1994-1-nsekhar@ti.com>
References: <20180105145248.1994-1-nsekhar@ti.com>
Message-ID: <CAK8P3a2r3FFx42bpXKfUSWMiKe2jJVO43gRjKUzZzet6oJv5rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 5, 2018 at 3:52 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
>
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.16/soc-v2
>
> for you to fetch changes up to 23bbeaef90ab7607d03428bbb708efe44f43c761:
>
>   ARM: davinci: constify gpio_led (2018-01-05 19:28:41 +0530)
>
> ----------------------------------------------------------------
> DaVinci SoC updates consisting of non-critical bug fixes including constifying
> data structures, removal of unnecessary newlines from gpio labels and code
> simplification.
>
> Also a defconfig update for DaVinci, enabling support for USB network adaptors.

Pulled into next/soc, thanks!

       Arnd

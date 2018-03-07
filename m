From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2018 16:03:18 +0100
Subject: [GIT PULL 3/3] DaVinci defconfig updates for v4.17
In-Reply-To: <20180227075745.23970-3-nsekhar@ti.com>
References: <20180227075745.23970-1-nsekhar@ti.com>
 <20180227075745.23970-3-nsekhar@ti.com>
Message-ID: <CAK8P3a03eQ5inAb-nZjQt-zqx793zLDzNRodH-0ObfWPnhsfPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 8:57 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.17/defconfig
>
> for you to fetch changes up to 35ba26772c827dbfc03be8adc3af8ff0d294b38f:
>
>   ARM: davinci_all_defconfig: set CONFIG_DAVINCI_WATCHDOG=y (2018-02-26 11:41:53 +0530)
>
> ----------------------------------------------------------------
> DaVinci defconfig updates for v4.17
>
> Enable SYSCON_REBOOT_MODE needed for Lego EV3 and build the DaVinci
> watchdog driver in so reboot works even when modules are not loaded.
>

Pulled into next/soc, thanks!

         Arnd

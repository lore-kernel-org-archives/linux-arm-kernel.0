From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 23:11:51 +0200
Subject: [GIT PULL 2/3] Allwinner dts changes for 4.14
In-Reply-To: <20170807033051.idjrno7obvet6kqj@wens.csie.org>
References: <20170807031910.66qj742m3egmdex5@wens.csie.org>
 <20170807033051.idjrno7obvet6kqj@wens.csie.org>
Message-ID: <CAK8P3a3kKGT8QEADd59_XO4sZRoefKPn02T2strKAFt85Hqj9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 7, 2017 at 5:30 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> The following changes since commit c50f9fb6c535edf4731eecb53d91ebc297e82e5b:
>
>   ARM: dts: sun8i: a83t: Switch to CCU device tree binding macros (2017-07-27 21:18:48 +0800)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-for-4.14
>
> for you to fetch changes up to 581ae76e96c6ab3bf942da7c4822ce9fa2074a01:
>
>   ARM: dts: sun8i: a83t: h8homlet: Enable micro-SD card and onboard eMMC (2017-08-05 22:06:58 +0800)
>
> ----------------------------------------------------------------
> The usual improvement patches:
>
>   - R_INTC interrupt controller compatible string update and device node
>     addition
>
>   - Battery charger enabled on the Cubietruck
>
>   - New board: Bananapi M2 Magic
>
>   - Ethernet and USB OTG enabled on the Beelink X2
>
>   - MMC enabled for A83T boards

Pulled into next/dt, thanks!

       Arnd

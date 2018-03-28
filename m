From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Mar 2018 17:16:38 +0200
Subject: [GIT PULL RESEND 3/4] Rockchip dts32 changes for 4.17
In-Reply-To: <11622789.b3QClBAtVJ@diego>
References: <12470502.BUvxkRrZk8@phil> <11622789.b3QClBAtVJ@diego>
Message-ID: <CAK8P3a3_jc2Px5iADy4xLmn9RXYu6czBodxogoOHpqGyLHz4Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2018 at 5:09 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/
> v4.17-rockchip-dts32-1
>
> for you to fetch changes up to 8dc9b9720380a3c16969932151ba92b558110b2f:
>
>   ARM: dts: rockchip: enable USB-OTG port on Radxa Rock2 Square (2018-02-19
> 06:53:35 +0100)
>
> ----------------------------------------------------------------
> For general soc-specific changes the rk322x socs got their correct grf
> compatible set. Other than that there are some board-specific changes
> like the Rock2 getting its otg port, recovery and power keys enabled.
>
> The vyasa board gained an enabled emmc node and the phyCORE boards
> got UHS speeds in their sd card and a fixed sd-card power supply.
>
> Finally the veyron boards dropped a nonstandard and unused property.

Pulled into next/dt, thanks!

     Arnd

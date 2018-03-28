From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Mar 2018 17:17:24 +0200
Subject: [GIT PULL RESEND 4/4] Rockchip dts64 changes for 4.17
In-Reply-To: <3276217.5UkD8yNFGY@diego>
References: <12470502.BUvxkRrZk8@phil> <3276217.5UkD8yNFGY@diego>
Message-ID: <CAK8P3a1FDEcJov-O_fdP8r-6Q56pBb3b0T_-=P1HSeQXqF+R9A@mail.gmail.com>
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
> v4.17-rockchip-dts64-1
>
> for you to fetch changes up to 3783f1eb8a8db3747e753c4aa972124e1309db4e:
>
>   arm64: dts: rockchip: remove keep-power-in-suspend from sdhci of rk3399-
> sapphire (2018-03-13 13:01:03 +0100)
>
> ----------------------------------------------------------------
> The rk3399 gained support its Cadence displayport controller and some
> minor additions like pins for 2ch i2s0 and the cif test clocks as well
> as a default rate for ACLK_VIO that should be 400MHz according to the TRM.
>
> The rk3328 got uart dmas fixed - a non-critical fix, as nobody was using
> that so far.
>
> New boards are the rk3328-based roc-rk3328-cc, the rk3368-based Lion-SOM
> + baseborad from Theobroma Systems and a standalone variant of the Sapphire
> board, as a lot of people where using that without the Exkavator baseboard.
>
> Sapphire also saw a lot of small cleanups of things that are not part
> of the actual Sapphire board, but the baseboard instead. The rk3399-puma
> board got i2s and tsadc support and Gru got its DP node enabled.

Pulled into next/dt, thanks!

        Arnd

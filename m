From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Mar 2018 17:15:13 +0200
Subject: [GIT PULL RESEND 2/4] Rockchip soc32 changes for 4.17
In-Reply-To: <4643567.9MCT7BxVJK@diego>
References: <12470502.BUvxkRrZk8@phil> <4643567.9MCT7BxVJK@diego>
Message-ID: <CAK8P3a2So56=yoxRXd1VQOz3AUZKXEgrWkFyE=VXsWY4_LzP+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2018 at 5:08 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/
> v4.17-rockchip-soc32-1
>
> for you to fetch changes up to 03151b8989257bfcee6cfd5f06d9a4a06b781cf3:
>
>   ARM: rockchip: Set name of pmu regmap_config in smp code (2018-03-12
> 11:09:36 +0100)
>
> ----------------------------------------------------------------
> Fix for the legacy pmu-regmap in the smp-code to have a real name
> and therefore not create a dummy* entry in debugfs.
>
> ----------------------------------------------------------------
> Jeffy Chen (1):
>       ARM: rockchip: Set name of pmu regmap_config in smp code
>

Pulled into next/soc, thanks!

     Arnd

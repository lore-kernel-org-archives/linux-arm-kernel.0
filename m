From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Aug 2017 22:30:12 +0200
Subject: [GIT PULL 3/3] i.MX defconfig updates for 4.14
In-Reply-To: <1503042820-13043-3-git-send-email-shawnguo@kernel.org>
References: <1503042820-13043-1-git-send-email-shawnguo@kernel.org>
 <1503042820-13043-3-git-send-email-shawnguo@kernel.org>
Message-ID: <CAK8P3a3kR9tx1Ubo+FUnPNf+x6=-s42WgfVivT5ocjNdWSdhFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 9:53 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
>
>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.14
>
> for you to fetch changes up to b834bc1c52b8d4b5a525eec619ad547da8bc3517:
>
>   ARM: imx_v6_v7_defconfig: Enable staging video4linux drivers (2017-07-25 16:42:51 +0800)
>
> ----------------------------------------------------------------
> i.MX defconfig updates for 4.14:
>  - Enable SPI_GPIO and GPIO_74X164 support which are useful for some
>    boards like imx7d-sabresd.
>  - Enable build of CODA video codec and staging video4linux drivers.

Pulled into next/defconfig, thanks!

     Arnd

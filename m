From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Apr 2018 16:47:21 +0200
Subject: [GIT PULL 1/1] Broadcom drivers fixes for 4.17
In-Reply-To: <20180416223035.578-1-f.fainelli@gmail.com>
References: <20180416223035.578-1-f.fainelli@gmail.com>
Message-ID: <CAK8P3a17tVs_40Bmwk=9qwOQvuzG67xwZ+g8CwDWrapB4yjJTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 12:30 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
>
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
>
> are available in the git repository at:
>
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.17/drivers-fixes
>
> for you to fetch changes up to 144345a4a8c3b497a3f60d3af9d6071a37660186:
>
>   soc: bcm2835: Make !RASPBERRYPI_FIRMWARE dummies return failure (2018-04-16 15:15:23 -0700)
>
> ----------------------------------------------------------------
> This pull request contains Broadcom SoCs drivers fixes, please pull the
> following:
>
> - Geert makes the Raspberry Pi firmwware return -ENOSYS (similar to
>   other subsystems) when CONFIG_RASPBERRYPI_FIRMWARE is off.
>
> - Florian fixes an incorrect annotation in the Raspberry Pi power domain
>   driver, spotted by sparse

Pulled into fixes, thanks!

       Arnd

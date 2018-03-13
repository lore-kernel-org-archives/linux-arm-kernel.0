From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Mar 2018 22:42:28 +0100
Subject: [GIT PULL 2/2] Broadcom defconfig changes for 4.17
In-Reply-To: <20180313195259.20496-2-f.fainelli@gmail.com>
References: <20180313195259.20496-1-f.fainelli@gmail.com>
 <20180313195259.20496-2-f.fainelli@gmail.com>
Message-ID: <CAK8P3a1VNpBLrdfB178errkiLaCn7D_1V-wXb-DWR-N6OcVHtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 8:52 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the git repository at:
>
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.17/defconfig
>
> for you to fetch changes up to 437fe668ab5ecdfd312605b0da15cf9138101d3f:
>
>   Merge tag 'bcm2835-defconfig-next-2018-02-28' into defconfig/next (2018-02-28 15:36:51 -0800)
>
> ----------------------------------------------------------------
> This pull request contains multi_v7_defconfig changes for Broadcom
> ARM-based SoC for 4.17, please pull the following:
>
> - Tuomas enables the BCM2835 AUX driver which is necessary to provide
>   console on the Raspberry Pi 3
>
> - Stefan turns on support for the BCM43438 Bluetooth adapter connected
>   via UART on the Raspberry Pi Zero Wireless and he also turns on
>   support for the thermal driver on the Pi 2 and 3.
>

Pulled into next/soc, thanks!

       Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Aug 2017 22:29:09 +0200
Subject: [GIT PULL 4/6] Broadcom defconfig changes for 4.14
In-Reply-To: <20170817183748.1450-5-f.fainelli@gmail.com>
References: <20170817183748.1450-1-f.fainelli@gmail.com>
 <20170817183748.1450-5-f.fainelli@gmail.com>
Message-ID: <CAK8P3a25RKbbxdPJ-k3-bV-CYyh+y9G37DpNcd4dkz6GdddwJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 8:37 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
>
>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
>
> are available in the git repository at:
>
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.14/defconfig
>
> for you to fetch changes up to 8f457cb291342d9ac04dbb8dc565619d220841f8:
>
>   ARM: multi_v7_defconfig: add CONFIG_BRCMSTB_THERMAL (2017-08-15 10:24:46 -0700)
>
> ----------------------------------------------------------------
> This pull request contains defconfig file changes for Broadcom ARM-based SoCs
> for 4.14, please pull the following:
>
> - Markus enables the Broadcom STB AVS thermal monitoring driver as a module
>   which is currently queued in Rui Zhang's tree
>
> - Stefan updates the bcm2835_defconfig to contain a few useful changes: the RPI
>   mini UART is enabled by default, the default CMA pool is bumped up to 32MB to
>   support VC4 usages and finally BRCMFMAC is enabled as module since this is the
>   wireless driver used on Raspberry Pi Zero Wireless.

Pulled into next/defconfig, thanks!

    Arnd

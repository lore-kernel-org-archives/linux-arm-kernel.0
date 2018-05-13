From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 13 May 2018 10:05:44 -0700
Subject: [GIT PULL 2/5] Broadcom defconfig-arm64 changes for 4.18
In-Reply-To: <20180511214339.24139-2-f.fainelli@gmail.com>
References: <20180511214339.24139-1-f.fainelli@gmail.com>
 <20180511214339.24139-2-f.fainelli@gmail.com>
Message-ID: <3810bc1a-c3e1-d38a-008e-e6b77280d9fa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/11/18 ? 14:43, Florian Fainelli a ?crit?:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.18/defconfig-arm64
> 
> for you to fetch changes up to dce4c94eedbd35cd63aa04ee9b022de6d23ee587:
> 
>   Merge tag 'bcm2835-defconfig-64-next-2018-04-30' into defconfig-arm64/next (2018-05-01 11:54:16 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM64-based SoCs defconfig changes
> for 4.18, please pull the following:
> 
> - Stefan provides a set of updates targeting the Raspberry Pi 3 B+
>   platform: LAN7515 USB Ethernet driver, Cypress CYW43455 Bluetooth when
>   using the Pi 3 B+ in AArch64 boot mode.
> 
> ----------------------------------------------------------------
> Florian Fainelli (1):
>       Merge tag 'bcm2835-defconfig-64-next-2018-04-30' into defconfig-arm64/next
> 
> Stefan Wahren (1):
>       arm64: defconfig: Enable LAN and BT support for RPi 3 B+

Olof, Arnd, Kevin, please disregard this pull request (v1) and consider
this one instead:

https://www.spinics.net/lists/arm-kernel/msg652043.html

thank you!
-- 
Florian

From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 May 2018 13:24:58 -0700
Subject: [GIT PULL 2/5 v2] Broadcom defconfig-arm64 changes for 4.18
In-Reply-To: <20180513170134.11472-1-f.fainelli@gmail.com>
References: <20180511214339.24139-2-f.fainelli@gmail.com>
 <20180513170134.11472-1-f.fainelli@gmail.com>
Message-ID: <20180514202458.ftyney2mfqa3qyov@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 13, 2018 at 10:01:34AM -0700, Florian Fainelli wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.18/defconfig-arm64
> 
> for you to fetch changes up to ebf089248dab2ef569e5e26a607f0977a71182b7:
> 
>   arm64: defconfig: Increase CMA size for VC4 (2018-05-13 09:55:21 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM64-based SoCs defconfig changes
> for 4.18, please pull the following:
> 
> - Stefan provides a set of updates targeting the Raspberry Pi 3 B+
>   platform: LAN7515 USB Ethernet driver, Cypress CYW43455 Bluetooth when
>   using the Pi 3 B+ in AArch64 boot mode. He also updates the ARM64
>   defconfig to create a bigger default CMA region to let the VideoCore 4
>   driver initialize correctly.
> 
> ----------------------------------------------------------------
> Florian Fainelli (1):
>       Merge tag 'bcm2835-defconfig-64-next-2018-04-30' into defconfig-arm64/next
> 
> Stefan Wahren (2):
>       arm64: defconfig: Enable LAN and BT support for RPi 3 B+
>       arm64: defconfig: Increase CMA size for VC4

Merged, thanks. When you revisit, feel free to delete the previous tag and
using a new name (-2 suffix or something). That way there's less risk for
confusion at our end.


-Olof

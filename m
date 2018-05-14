From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 May 2018 13:26:45 -0700
Subject: [GIT PULL 3/5] Broadcom devicetree changes for 4.18
In-Reply-To: <20180511214339.24139-3-f.fainelli@gmail.com>
References: <20180511214339.24139-1-f.fainelli@gmail.com>
 <20180511214339.24139-3-f.fainelli@gmail.com>
Message-ID: <20180514202645.tuovyugwijhfd2au@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 02:43:36PM -0700, Florian Fainelli wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.18/devicetree
> 
> for you to fetch changes up to a05f1e36a57d02374a203719abc5bf2e8c51e125:
> 
>   ARM: dts: BCM5301X: Switch D-Link DIR-885L to the new partitions syntax (2018-05-11 09:46:38 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoC Device Tree changes
> for 4.18, please pull the following:
> 
> - Stefan provides updates to the BCM2835 RNG Device Tree binding and
>   Device Tree node by adding its missing interrupt line.
> 
> - Rafal switches the Luxul XWC-1000 and the D-Link DIR-885L to the new
>   partitions syntax which allows specifying a partition parser
> 
> - Rafal also updates a bunch of BCM5301X Device Tree source files to a
>   more standard SPDX tag and dual GPL 2.0 and MIT. This is a follow-up
>   to this discussion with Greg:
>   https://lkml.org/lkml/2018/4/28/179
> 
> - Dan adds support for two Luxul devices: XAP-1610 (based on BCM47094)
>   and XWR-3150 V1 (similar to XWR-3100)
> 
> - Stefan provides a set of updates to the BCM283x Device Tree sources to
>   support the Raspberry Pi 3 B+ for both the ARM and ARM64 kernels. He
>   adds the required nodes for the LAN7515 USB Ethernet, Cypress CYW43455
>   BT/WiFi combo chip. Stefan also provides a few fixes for the PWM pin
>   assignment for RPi 3B and Zero/Zero W. Finally, Stefan adds the
>   missing GPIOs for controlling additional peripherals now that support
>   for the RPi 3 GPIO expander has landed

Merged, thanks!


-Olof

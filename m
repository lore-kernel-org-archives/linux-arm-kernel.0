From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 25 Sep 2014 14:33:32 -0700
Subject: [GIT PULL #2] ARM: BCM: Broadcom BCM63138 support
In-Reply-To: <1410977394-27987-1-git-send-email-f.fainelli@gmail.com>
References: <1410977394-27987-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <54248A2C.9000203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2014 11:09 AM, Florian Fainelli wrote:
> Changes in v2:
> - rebased against v3.17-rc1
> - added Arnd's Acked-by
> - added a proper tag to pull from
> 
> Thank you!
> 
> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> 
>   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> 
> are available in the git repository at:
> 
>   http://github.com/brcm/linux.git tags/bcm63138-v4
> 
> for you to fetch changes up to e076e96227ef6b5b66cfdd79e75401bd2f6d532f:
> 
>   MAINTAINERS: add entry for the Broadcom BCM63xx ARM SoCs (2014-09-17 10:56:08 -0700)

Now that we have hopefully cleared out the mach-bcm situation, is there
anything blocking this pull request?

Thanks!

> 
> ----------------------------------------------------------------
> Florian Fainelli (5):
>       ARM: BCM63XX: add basic support for the Broadcom BCM63138 DSL SoC
>       ARM: BCM63XX: add low-level UART debug support
>       ARM: BCM63XX: add BCM63138 minimal Device Tree
>       ARM: BCM63XX: add BCM963138DVT Reference platform DTS
>       MAINTAINERS: add entry for the Broadcom BCM63xx ARM SoCs
> 
>  .../devicetree/bindings/arm/bcm/bcm63138.txt       |   9 ++
>  MAINTAINERS                                        |   8 ++
>  arch/arm/Kconfig.debug                             |  18 ++-
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/bcm63138.dtsi                    | 134 +++++++++++++++++++++
>  arch/arm/boot/dts/bcm963138dvt.dts                 |  30 +++++
>  arch/arm/include/debug/bcm63xx.S                   |  33 +++++
>  arch/arm/mach-bcm/Kconfig                          |  17 +++
>  arch/arm/mach-bcm/Makefile                         |   3 +
>  arch/arm/mach-bcm/bcm63xx.c                        |  27 +++++
>  10 files changed, 278 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/bcm63138.txt
>  create mode 100644 arch/arm/boot/dts/bcm63138.dtsi
>  create mode 100644 arch/arm/boot/dts/bcm963138dvt.dts
>  create mode 100644 arch/arm/include/debug/bcm63xx.S
>  create mode 100644 arch/arm/mach-bcm/bcm63xx.c
> 

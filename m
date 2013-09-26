From: bcousson@baylibre.com (Benoit Cousson)
Date: Thu, 26 Sep 2013 11:36:01 +0200
Subject: [PATCH 0/9] ARM: dts: DT data for OMAP platforms for v3.13
In-Reply-To: <1380146469-29496-1-git-send-email-joelf@ti.com>
References: <1380146469-29496-1-git-send-email-joelf@ti.com>
Message-ID: <52440001.8070804@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joel,

On 26/09/2013 00:01, Joel Fernandes wrote:
> Following series is a collection of dts patches for the below features:
> crypto:
>   aes, sha on am335x
>   aes, des on am437x
>   aes, des on omap4
> display:
>    beaglebone black HDMI
>    am335x-evm panel
>
> Series is based on Benoit Cousson's for_3.13/dts branch (commit sha 45646cd)
> Available at: git at github.com:joelagnel/linux-kernel.git (branch for-benoit)

Thanks for the update and rebase.

I'll check the series ASAP.

Thanks,
Benoit

>
> Benoit Parrot (1):
>    ARM: dts: AM33XX: Add LCDC info into am335x-evm
>
> Darren Etheridge (1):
>    dts: boneblack: add pinmux and hdmi node to enable display
>
> Joel Fernandes (5):
>    omap4: dts: Add node for AES
>    omap4: dts: Add node for DES3DES module
>    am33xx: dts: Fix AES interrupt number
>    ARM: am437x: dts: Add AES node for am437x
>    ARM: am437x: dts: Add DES node for am437x
>
> Mark A. Greer (2):
>    ARM: dts: Add SHAM data and documentation for AM33XX
>    ARM: dts: Add AES data and documentation for AM33XX
>
>   .../devicetree/bindings/crypto/omap-aes.txt        | 34 ++++++++++
>   .../devicetree/bindings/crypto/omap-sham.txt       | 31 +++++++++
>   arch/arm/boot/dts/am335x-bone.dts                  |  8 +++
>   arch/arm/boot/dts/am335x-boneblack.dts             | 48 +++++++++++++
>   arch/arm/boot/dts/am335x-evm.dts                   | 79 ++++++++++++++++++++++
>   arch/arm/boot/dts/am335x-evmsk.dts                 |  8 +++
>   arch/arm/boot/dts/am33xx.dtsi                      | 30 ++++++++
>   arch/arm/boot/dts/am4372.dtsi                      | 16 +++++
>   arch/arm/boot/dts/omap4.dtsi                       | 20 ++++++
>   9 files changed, 274 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/crypto/omap-aes.txt
>   create mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt
>

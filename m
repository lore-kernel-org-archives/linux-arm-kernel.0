From: bcousson@baylibre.com (Benoit Cousson)
Date: Tue, 08 Oct 2013 17:51:07 +0200
Subject: [PATCH v3 0/3] AM33XX crypto DTS patches
In-Reply-To: <1380999877-20884-1-git-send-email-joelf@ti.com>
References: <1380999877-20884-1-git-send-email-joelf@ti.com>
Message-ID: <525429EB.90304@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joel,

n 05/10/2013 21:04, Joel Fernandes wrote:
> These patches are some minor fixups and changes to commit messages to the
> AM33XX crypto (aes, sham) patches with reference to the comments at:
> http://comments.gmane.org/gmane.linux.drivers.devicetree/45961
>
> Joel Fernandes (1):
>    ARM: dts: AM33XX: Fix AES interrupt number
>
> Mark A. Greer (2):
>    ARM: dts: AM33XX: Add SHAM data and documentation
>    ARM: dts: AM33XX: Add AES data and documentation
>
>   .../devicetree/bindings/crypto/omap-aes.txt        | 31 ++++++++++++++++++++++
>   .../devicetree/bindings/crypto/omap-sham.txt       | 28 +++++++++++++++++++
>   arch/arm/boot/dts/am335x-bone.dts                  |  8 ++++++
>   arch/arm/boot/dts/am335x-evm.dts                   |  8 ++++++
>   arch/arm/boot/dts/am335x-evmsk.dts                 |  8 ++++++
>   arch/arm/boot/dts/am33xx.dtsi                      | 19 +++++++++++++
>   6 files changed, 102 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/crypto/omap-aes.txt
>   create mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt
>

I've just applied this series and the remaining ones from the previous 
version.

Thanks,
Benoit

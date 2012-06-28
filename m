From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Thu, 28 Jun 2012 10:01:51 +0000
Subject: [PATCH 0/3] Add device tree support to AM33XX SoC
In-Reply-To: <1340358050-29560-1-git-send-email-anilkumar@ti.com>
References: <1340358050-29560-1-git-send-email-anilkumar@ti.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13E9E4247@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Gentle remainder to this patch series.

On Fri, Jun 22, 2012 at 15:10:46, AnilKumar, Chimata wrote:
> This patch series add device tree support for AM33XX SoC family.
> 
> Initialy Hiremath Vaibhav submitted a patch for AM33XX devices
> based on omap3 family. Details at
> http://marc.info/?t=132687107200002&r=1&w=2
> 
> AM33XX family is varied from omap3 family in these aspects
> like memory maps, peripheral base addresses and configuration
> parameters. In some cases we have to use a mix of omap3 and
> omap4 parameters. So a seperate am33xx.dtsi file is created
> for all the devices comes under am33xx family and revert of
> above patch is required.
> 
> Two sepearte device tree source files are created (am335x-evm.dts
> and am335x-bone.dts) to add support for AM335X EVM and BeagleBone
> boards.
> 
> Linux booting is tested on AM335X-EVM and BeagleBone boards.
> 
> AnilKumar Ch (4):
>   Revert "arm/dts: Add support for TI AM335x EVM board"
>   arm/dts: Add initial DT support for AM33XX SoC family
>   arm/dts: Add support for AM335x EVM
>   arm/dts: Add support for AM335x BeagleBone
> 
>  .../devicetree/bindings/arm/omap/omap.txt          |    3 +
>  arch/arm/boot/dts/am335x-bone.dts                  |   20 +++
>  arch/arm/boot/dts/am335x-evm.dts                   |   25 +--
>  arch/arm/boot/dts/am33xx.dtsi                      |  189 ++++++++++++++++++++
>  4 files changed, 215 insertions(+), 22 deletions(-)
>  create mode 100644 arch/arm/boot/dts/am335x-bone.dts
>  create mode 100644 arch/arm/boot/dts/am33xx.dtsi
> 
> -- 
> 1.7.9.5

Thanks
AnilKumar

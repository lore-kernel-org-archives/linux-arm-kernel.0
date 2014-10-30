From: rogerq@ti.com (Roger Quadros)
Date: Thu, 30 Oct 2014 16:36:05 +0200
Subject: [PATCH 0/4] ARM: dts: dra72-evm: NAND and USB support
In-Reply-To: <1413888080-2669-1-git-send-email-rogerq@ti.com>
References: <1413888080-2669-1-git-send-email-rogerq@ti.com>
Message-ID: <54524CD5.5060103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 10/21/2014 01:41 PM, Roger Quadros wrote:
> Hi Tony,
> 
> These patches add NAND and USB support for DRA72-evm.
> Patches are for v3.19 and based on v3.18-rc1.
> 
> I've tested that NAND and USB host works fine on DRA72-evm.
> 
> I couldn't get USB gadget mode to work. It doesn't work on DRA7-evm either.
> There seems to be some issue at the driver level. The dts entries are correct though.

Any further comments on this? Can we please queue this for -next? Thanks.

cheers,
-roger

> 
> cheers,
> -roger
> 
> George Cherian (1):
>   ARM: dts: dra72-evm: Enable USB support for dra72-evm.
> 
> Roger Quadros (3):
>   ARM: dts: dra72-evm: Add NAND support
>   ARM: dts: DRA7: Move USB_OTG 4 to dra74x.dtsi
>   ARM: dts: dra72-evm: Add regulator information to USB2 PHYs
> 
>  arch/arm/boot/dts/dra7.dtsi     |  20 ------
>  arch/arm/boot/dts/dra72-evm.dts | 147 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/dra74x.dtsi   |  22 ++++++
>  3 files changed, 169 insertions(+), 20 deletions(-)
> 

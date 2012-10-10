From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 10 Oct 2012 17:50:52 +0200
Subject: [PATCH 0/3] ARM: dts: EMIF and LPDDR2 device tree data for OMAP5
 boards
In-Reply-To: <1349870716-25511-1-git-send-email-lokeshvutla@ti.com>
References: <1349870716-25511-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <5075995C.4060502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You should CC devicetree-discuss at lists.ozlabs.org for any Device tree
patches. This is applicable for the whole series.

On 10/10/2012 02:05 PM, Lokesh Vutla wrote:
> Patch 1:
> 	Renaming elpida_ecb240abacn.dtsi as lpddr2_data.dtsi
> Patch 2:
> 	Correcting size of memory defined for omap5
> Patch 3:
> 	EMIF and LPDDR2 device tree data for OMAP5 boards
> 

There is not point to list the patch subject in a cover letter.
You should just introduce the series and ideally give details about the
test like you have done below.

The cover letter should mostly be written like an email.

Benoit

> Testing:
> - Boot tested on omap5-sevm board
> - Built emif as a module
> 
> Lokesh Vutla (3):
>   ARM: dts: Renaming elpida_ecb240abacn.dts as lpddr2_data.dtsi
>   ARM: dts: Correcting size of memory defined for omap5
>   ARM: dts: EMIF and LPDDR2 device tree data for OMAP5 boards
> 
>  arch/arm/boot/dts/elpida_ecb240abacn.dtsi |   67 ---------------
>  arch/arm/boot/dts/lpddr2_data.dtsi        |  129 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap4-panda.dts         |    2 +-
>  arch/arm/boot/dts/omap4-sdp.dts           |    2 +-
>  arch/arm/boot/dts/omap5-evm.dts           |   13 ++-
>  arch/arm/boot/dts/omap5.dtsi              |   18 ++++
>  6 files changed, 161 insertions(+), 70 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/elpida_ecb240abacn.dtsi
>  create mode 100644 arch/arm/boot/dts/lpddr2_data.dtsi
> 

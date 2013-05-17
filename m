From: B45370@freescale.com (Sharma Bhupesh-B45370)
Date: Fri, 17 May 2013 09:56:22 +0000
Subject: ARM Cortex-A7 support in Linux
Message-ID: <A1A6EA40F8503D48BB002B42BD65974E295341@039-SN2MPN1-012.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin, list

I am trying to locate support for Cortex-A7 soc (in Linux) and it's primary features like:
- SMMU 400 (Virtualization)
- CCI 400 
- LPAE
- GIC 400

We wish to use this core in one of our SoCs and will like to reuse most of the code.
I can see some support added for:
- Cortex-A7 dts by Pawel for Versatile board
	http://linux-arm.org/git?p=arm-dts.git;a=commitdiff;h=81195261a984e8c734f319eda80f86ba82b37d27

- LPAE support by Catalin
	http://lxr.linux.no/linux+v3.9.2/arch/arm/mm/Kconfig#L589

- CCI 400 RFC patches from Lorenzo
	https://patchwork.kernel.org/patch/2508121/

- Basic dts support for GIC virtualization support is already present here:
	http://lxr.linux.no/linux+v3.9.2/Documentation/devicetree/bindings/arm/gic.txt#L64

But I am not sure about the following:
- Does the current GIC driver support GIC-400 features as well?

- I don't see many of these features supported in u-boot. Any idea if any work is going on for the same? 

Thanks for your help.
Regards,
Bhupesh

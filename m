From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Apr 2015 13:34:12 -0700
Subject: [GIT PULL] qcom dt changes for 4.1
In-Reply-To: <alpine.DEB.2.02.1503271147110.17719@galak-ubuntu.qualcomm.com>
References: <alpine.DEB.2.02.1503271147110.17719@galak-ubuntu.qualcomm.com>
Message-ID: <20150403203412.GA23023@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 27, 2015 at 11:49:26AM -0500, Kumar Gala wrote:
> The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
> 
>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-dt-for-4.1
> 
> for you to fetch changes up to 1be95ed01c190ca74677798348306a50ad0d46c1:
> 
>   ARM: dts: qcom: Add idle state device nodes for 8064 (2015-03-25 16:38:16 -0500)
> 
> ----------------------------------------------------------------
> Qualcomm ARM Based Device Tree Updates for v4.1
> 
> * Updated GIC binding to include Qualcomm GIC compatible
> * Added binding and updated dts for TCSR (Top Control and Status Register)
> * Added LCC clocks to IPQ8064/APQ8064/MSM8960 device trees
> * Added LPASS support to IPQ8064 device tree
> * Added SPMI PMIC & device support to APQ8084 and MSM8974
> * Added support for MSM8916/APQ8016 SoC (64-bit) and MTP8916/SBC8016 boards
> * Added support for qcom,saw2 & qcom,idle-states on MSM8974/APQ8084/APQ8064
> 
> ----------------------------------------------------------------
> Andy Gross (5):
>       mfd: qcom,tcsr: Add device tree binding for TCSR
>       arm: dts: qcom: Add TCSR support for APQ8064
>       arm: dts: qcom: Add TCSR support for IPQ8064
>       arm: dts: qcom: Add TCSR support for MSM8660
>       arm: dts: qcom: Add TCSR support for MSM8960
> 
> Georgi Djakov (1):
>       dt-bindings: Add #defines for MSM8916 clocks and resets
> 
> Ivan T. Ivanov (3):
>       arm: dts: qcom: Add SPMI PMIC Arbiter nodes for APQ8084 and MSM8974
>       arm: dts: qcom: Add 8x74 chipset SPMI PMIC's nodes
>       arm: dts: qcom: Add APQ8084 chipset SPMI PMIC's nodes
> 
> Kenneth Westfield (1):
>       arm: dts: qcom: Add LPASS Audio HW to IPQ8064 device tree
> 
> Kumar Gala (4):
>       arm: qcom: dts: gic: add compatible string for Qualcomm MSM GICs
>       arm: dts: qcom: Add LCC nodes
>       arm64: dts: Add Qualcomm MSM8916 SoC and evaluation board dts
>       arm64: dts: Add Qualcomm APQ8016 SBC evaluation board dts

We are still merging 64-bit material in a separate branch. Since you're mixing
contents here it means that conflicts between the two percolate all the way up
to our pull requests to Linus.

I've cherry-picked the branch contents here instead, so I've picked up the
contents but spread across next/dt and next/arm64. Please keep them separate in
the future so we can merge branches instead.


Thanks,

-Olof

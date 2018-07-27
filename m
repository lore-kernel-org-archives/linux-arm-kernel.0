From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 27 Jul 2018 17:44:56 -0500
Subject: [arm-soc:qcom/arm64 5/10]
 arch/arm64/boot/dts/qcom/sdm845.dtsi:10:10: fatal error:
 dt-bindings/soc/qcom,rpmh-rsc.h: No such file or directory
In-Reply-To: <201807262312.blW4meoN%fengguang.wu@intel.com>
References: <201807262312.blW4meoN%fengguang.wu@intel.com>
Message-ID: <20180727224456.GA6189@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 11:33:17PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git qcom/arm64
> head:   e53db018315b7660bb7000a29e79faff2496c2c2
> commit: c83545d95376c2249c7990ce2dd76f387ce68bef [5/10] arm64: dts: sdm845: Add rpmh-rsc node
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout c83545d95376c2249c7990ce2dd76f387ce68bef
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/arm64/boot/dts/qcom/sdm845-mtp.dts:10:0:
> >> arch/arm64/boot/dts/qcom/sdm845.dtsi:10:10: fatal error: dt-bindings/soc/qcom,rpmh-rsc.h: No such file or directory
>     #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    compilation terminated.
> 
> vim +10 arch/arm64/boot/dts/qcom/sdm845.dtsi
> 
>   > 10	#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>     11	

This file is included in the qcom-drivers-for-4.19 pull request.  I should have noted
this on the ARM64 DTS pull request.


Andy

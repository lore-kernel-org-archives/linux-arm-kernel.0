From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 6 Dec 2016 14:35:17 -0500
Subject: [PATCH 2/2] arm64: dts: NS2: add support for XMC form factor
In-Reply-To: <201612061647.t3qcDWHR%fengguang.wu@intel.com>
References: <1480979542-26871-3-git-send-email-jon.mason@broadcom.com>
 <201612061647.t3qcDWHR%fengguang.wu@intel.com>
Message-ID: <20161206193516.GA1982@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 04:37:48PM +0800, kbuild test robot wrote:
> Hi Jon,
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on v4.9-rc8]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Jon-Mason/arm64-dts-NS2-reserve-memory-for-Nitro-firmware/20161206-125631
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> config: arm64-allmodconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
> >> Error: arch/arm64/boot/dts/broadcom/ns2-xmc.dts:56.1-6 Label or path enet not found
> >> Error: arch/arm64/boot/dts/broadcom/ns2-xmc.dts:132.1-7 Label or path pcie8 not found
> >> Error: arch/arm64/boot/dts/broadcom/ns2-xmc.dts:148.1-6 Label or path qspi not found
> >> FATAL ERROR: Syntax error parsing input tree

This patch series is based on top of others queued in Florian's tree.
The errors referenced above are not present when based on this tree,
as those labels are already in the NS2 DT files there.

Thanks,
Jon

> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 2 Jan 2017 10:01:24 +0100
Subject: [PATCH] mtd: nand: Update dependency of IFC for LS1021A
In-Reply-To: <201612291704.0tMw9Uis%fengguang.wu@intel.com>
References: <1482973102-47659-1-git-send-email-b18965@freescale.com>
 <201612291704.0tMw9Uis%fengguang.wu@intel.com>
Message-ID: <20170102100124.78ca7d7e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alison,

On Thu, 29 Dec 2016 17:52:37 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Alison,
> 
> [auto build test WARNING on mtd/master]
> [also build test WARNING on v4.10-rc1 next-20161224]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Alison-Wang/mtd-nand-Update-dependency-of-IFC-for-LS1021A/20161229-125233
> base:   git://git.infradead.org/linux-mtd.git master
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All warnings (new ones prefixed by >>):
> 
> warning: (MTD_NAND_FSL_IFC) selects FSL_IFC which has unmet direct dependencies (MEMORY && (FSL_SOC || ARCH_LAYERSCAPE))

Do you have another patch adding the '||?SOC_LS1021A' dependency on
FSL_IFC? If so, please send both patches in the same series.

Thanks,

Boris

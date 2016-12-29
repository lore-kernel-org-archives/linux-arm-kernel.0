From: lkp@intel.com (kbuild test robot)
Date: Thu, 29 Dec 2016 17:52:37 +0800
Subject: [PATCH] mtd: nand: Update dependency of IFC for LS1021A
In-Reply-To: <1482973102-47659-1-git-send-email-b18965@freescale.com>
Message-ID: <201612291704.0tMw9Uis%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alison,

[auto build test WARNING on mtd/master]
[also build test WARNING on v4.10-rc1 next-20161224]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alison-Wang/mtd-nand-Update-dependency-of-IFC-for-LS1021A/20161229-125233
base:   git://git.infradead.org/linux-mtd.git master
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

warning: (MTD_NAND_FSL_IFC) selects FSL_IFC which has unmet direct dependencies (MEMORY && (FSL_SOC || ARCH_LAYERSCAPE))

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59438 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161229/8afb2f05/attachment-0001.gz>

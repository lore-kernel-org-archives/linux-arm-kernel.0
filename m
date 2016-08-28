From: lkp@intel.com (kbuild test robot)
Date: Sun, 28 Aug 2016 12:25:01 +0800
Subject: [PATCH v2] dmaengine: mv_xor: Add support for IO (PCIe) src/dst
 areas
In-Reply-To: <20160826053901.18763-1-sr@denx.de>
Message-ID: <201608281258.FdvY74rc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.8-rc3 next-20160825]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Stefan-Roese/dmaengine-mv_xor-Add-support-for-IO-PCIe-src-dst-areas/20160826-134151
config: arm64-allyesconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `mv_xor_add_io_win.isra.13':
>> zynq-fpga.c:(.text+0x31dadc): undefined reference to `mvebu_mbus_get_io_win_info'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 51379 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160828/7a3d8f10/attachment-0001.obj>

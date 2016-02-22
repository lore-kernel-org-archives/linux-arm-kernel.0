From: lkp@intel.com (kbuild test robot)
Date: Mon, 22 Feb 2016 18:01:43 +0800
Subject: [PATCH v9 2/6] clk: hisilicon: add CRG driver for hi3519 soc
In-Reply-To: <1456127280-23275-3-git-send-email-xuejiancheng@huawei.com>
Message-ID: <201602221742.MKAlpbcd%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jiancheng,

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v4.5-rc5 next-20160222]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jiancheng-Xue/ARM-hisi-Add-initial-support-including-clock-driver-for-Hi3519-soc/20160222-160736
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: xtensa-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

warning: (COMMON_CLK_HI3519) selects RESET_HISI which has unmet direct dependencies (COMMON_CLK && ARCH_HISI)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44077 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160222/e99643f5/attachment-0001.obj>

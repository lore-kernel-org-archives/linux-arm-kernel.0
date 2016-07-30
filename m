From: lkp@intel.com (kbuild test robot)
Date: Sat, 30 Jul 2016 09:56:13 +0800
Subject: [PATCH net-next 08/10] drivers: net: xgene: Poll link status via
 GPIO
In-Reply-To: <1469838843-19943-9-git-send-email-isubramanian@apm.com>
Message-ID: <201607300959.t6qIYVZo%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Iyappan-Subramanian/Fix-warning-and-issues/20160730-083713
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

warning: (NET_XGENE) selects GPIO_XGENE_SB which has unmet direct dependencies (GPIOLIB && ARCH_XGENE && OF_GPIO)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45764 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160730/8ebd0966/attachment-0001.obj>

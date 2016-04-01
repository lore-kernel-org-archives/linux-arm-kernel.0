From: lkp@intel.com (kbuild test robot)
Date: Fri, 1 Apr 2016 23:31:05 +0800
Subject: [PATCH 1/2] phy: Group vendor specific phy drivers
In-Reply-To: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <201604012318.jqf9PVXF%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.6-rc1 next-20160401]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Vivek-Gautam/phy-Group-vendor-specific-phy-drivers/20160401-192920
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> make[4]: *** No rule to make target 'drivers/phy/qcom/+=', needed by 'drivers/phy/qcom/built-in.o'.
   make[4]: Target '__build' not remade because of errors.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 56241 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160401/2518aa70/attachment-0001.obj>

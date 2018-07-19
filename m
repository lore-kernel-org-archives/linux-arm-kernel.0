From: lkp@intel.com (kbuild test robot)
Date: Thu, 19 Jul 2018 13:31:17 +0800
Subject: [PATCH] phy: Add driver for Cadence MHDP DisplayPort SD0801 PHY
In-Reply-To: <1531920003-7364-1-git-send-email-stelford@cadence.com>
References: <1531920003-7364-1-git-send-email-stelford@cadence.com>
Message-ID: <201807191323.JVEjlMdZ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on phy/next]
[also build test ERROR on v4.18-rc5]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Scott-Telford/phy-Add-driver-for-Cadence-MHDP-DisplayPort-SD0801-PHY/20180719-025849
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git next
config: um-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um 

All errors (new ones prefixed by >>):

>> ERROR: "devm_ioremap_resource" [drivers/phy/cadence/phy-cadence-dp.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 19856 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180719/c9b2dbe3/attachment-0001.gz>

From: lkp@intel.com (kbuild test robot)
Date: Tue, 30 May 2017 03:02:20 +0800
Subject: [PATCH v1 4/5] regulator: pfuze100-regulator: provide
 pm_power_off_prepare handler
In-Reply-To: <20170529170924.25488-4-o.rempel@pengutronix.de>
Message-ID: <201705300223.IOrAMKo4%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksij,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.12-rc3 next-20170529]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oleksij-Rempel/ARM-imx6q-provide-documentation-for-new-fsl-pmic_stby_poweroff-property/20170530-011619
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: i386-randconfig-a0-05272032 (attached as .config)
compiler: gcc-5 (Debian 5.4.1-2) 5.4.1 20160904
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> ERROR: "lookup_symbol_name" [drivers/regulator/pfuze100-regulator.ko] undefined!
>> ERROR: "pm_power_off_prepare" [drivers/regulator/pfuze100-regulator.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 21584 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170530/4fc18fda/attachment-0001.gz>

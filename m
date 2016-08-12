From: lkp@intel.com (kbuild test robot)
Date: Fri, 12 Aug 2016 14:17:48 +0800
Subject: [PATCH] soc: ti: wkup_m3_ipc: switch to using remoteproc OF
 infrastructure
In-Reply-To: <20160812003529.519-1-s-anna@ti.com>
Message-ID: <201608121427.KnlsFKGE%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.8-rc1 next-20160811]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Suman-Anna/soc-ti-wkup_m3_ipc-switch-to-using-remoteproc-OF-infrastructure/20160812-085217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> ERROR: "of_update_property" [drivers/soc/ti/wkup_m3_ipc.ko] undefined!
>> ERROR: "of_remove_property" [drivers/soc/ti/wkup_m3_ipc.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 58499 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160812/cb144d63/attachment-0001.obj>

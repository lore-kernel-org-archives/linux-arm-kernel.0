From: lkp@intel.com (kbuild test robot)
Date: Mon, 5 Mar 2018 01:56:12 +0800
Subject: [PATCH v4 16/22] nvmem: meson-efuse: Do no gate COMPILE_TEST
 with MESON_SM
In-Reply-To: <20180228144106.16363-17-andrew.smirnov@gmail.com>
References: <20180228144106.16363-17-andrew.smirnov@gmail.com>
Message-ID: <201803050159.MGKYpzrT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc3 next-20180302]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrey-Smirnov/Verbatim-device-names-and-devm_nvmem_-un-register/20180303-220801
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> ERROR: "meson_sm_call" [drivers/nvmem/nvmem_meson_efuse.ko] undefined!
>> ERROR: "meson_sm_call_read" [drivers/nvmem/nvmem_meson_efuse.ko] undefined!

coccinelle warnings: (new ones prefixed by >>)

>> drivers/nvmem/meson-efuse.c:64:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63100 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180305/2de1536b/attachment-0001.gz>

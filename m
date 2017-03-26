From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 27 Mar 2017 04:36:42 +0800
Subject: [nomadik:gemini 43/43] ERROR: "of_flash_probe_versatile"
 [drivers/mtd/maps/physmap_of.ko] undefined!
Message-ID: <201703270440.a4OOn0b4%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini
head:   5d333034d4b679ccad1e29b6041238c4a3f10984
commit: 5d333034d4b679ccad1e29b6041238c4a3f10984 [43/43] mtd: physmap_of: really fix the physmap add-ons
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 5d333034d4b679ccad1e29b6041238c4a3f10984
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> ERROR: "of_flash_probe_versatile" [drivers/mtd/maps/physmap_of.ko] undefined!
>> ERROR: "of_flash_probe_gemini" [drivers/mtd/maps/physmap_of.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59014 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170327/4af74f98/attachment-0001.gz>

From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 31 Jan 2017 09:40:05 +0800
Subject: [nomadik:gemini 22/34] ERROR: "of_flash_probe_versatile"
 [drivers/mtd/maps/physmap_of.ko] undefined!
Message-ID: <201701310903.CMbeep99%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini
head:   9a47d8671a4fc4f905ba6886571de5540d9b9e47
commit: c7c96dba6836dbced6066fd29b608df310f824e6 [22/34] ARM: gemini: convert to ARMv4 multiplatform
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout c7c96dba6836dbced6066fd29b608df310f824e6
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the nomadik/gemini HEAD 9a47d8671a4fc4f905ba6886571de5540d9b9e47 builds fine.
      It only hurts bisectibility.

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
Size: 57940 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170131/7baad246/attachment-0001.gz>

From: lkp@intel.com (kbuild test robot)
Date: Tue, 24 Jul 2018 06:15:28 +0800
Subject: [PATCH v5] media: dvb-frontends: add Socionext MN88443x ISDB-S/T
 demodulator driver
In-Reply-To: <20180723085150.24266-1-suzuki.katsuhiro@socionext.com>
References: <20180723085150.24266-1-suzuki.katsuhiro@socionext.com>
Message-ID: <201807240508.gpMy7uIR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Katsuhiro,

I love your patch! Yet something to improve:

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.18-rc6 next-20180723]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Katsuhiro-Suzuki/media-dvb-frontends-add-Socionext-MN88443x-ISDB-S-T-demodulator-driver/20180724-050011
base:   git://linuxtv.org/media_tree.git master
config: i386-randconfig-i1-201829 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> drivers/media/dvb-frontends/mn88443x.c:15:10: fatal error: sc1501a.h: No such file or directory
    #include "sc1501a.h"
             ^~~~~~~~~~~
   compilation terminated.

vim +15 drivers/media/dvb-frontends/mn88443x.c

    14	
  > 15	#include "sc1501a.h"
    16	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27693 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/6fbfffe0/attachment-0001.gz>

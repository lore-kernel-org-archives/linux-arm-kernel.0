From: lkp@intel.com (kbuild test robot)
Date: Tue, 15 May 2018 15:49:10 +0800
Subject: [PATCH] media: dvb-frontends: add Socionext SC1501A ISDB-S/T
 demodulator driver
In-Reply-To: <20180515003749.9980-1-suzuki.katsuhiro@socionext.com>
References: <20180515003749.9980-1-suzuki.katsuhiro@socionext.com>
Message-ID: <201805151554.iD1WEuzX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Katsuhiro,

I love your patch! Yet something to improve:

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.17-rc5 next-20180514]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Katsuhiro-Suzuki/media-dvb-frontends-add-Socionext-SC1501A-ISDB-S-T-demodulator-driver/20180515-091453
base:   git://linuxtv.org/media_tree.git master
config: i386-allyesconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/media/dvb-frontends/sc1501a.o: In function `sc1501a_set_frontend':
>> sc1501a.c:(.text+0xbe0): undefined reference to `__divdi3'
   sc1501a.c:(.text+0xc01): undefined reference to `__divdi3'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62660 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180515/df8965ae/attachment-0001.gz>

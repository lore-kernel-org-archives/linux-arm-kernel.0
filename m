From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 6 Jan 2017 08:43:46 +0800
Subject: [nomadik:lis3lv02 5/6] warning: (IIO_ST_ACCEL_3AXIS) selects
 IIO_ST_ACCEL_SPI_3AXIS which has unmet direct dependencies (IIO && ..)
Message-ID: <201701060843.W5UJu28i%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git lis3lv02
head:   e343deae8006a1fc109534497c943eab51a1c2a8
commit: 0a9710dd480b06b6fefefdedc732020f2297e247 [5/6] iio: accel: st_accel: handle deprecated bindings
config: powerpc-allyesconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 0a9710dd480b06b6fefefdedc732020f2297e247
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All warnings (new ones prefixed by >>):

warning: (IIO_ST_ACCEL_3AXIS) selects IIO_ST_ACCEL_SPI_3AXIS which has unmet direct dependencies (IIO && !SENSORS_LIS3_SPI && IIO_ST_ACCEL_3AXIS && IIO_ST_SENSORS_SPI)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 51856 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170106/9cb0f0b3/attachment-0001.gz>

From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 6 Jan 2017 04:03:24 +0800
Subject: [nomadik:lis3lv02 5/6] warning: (IIO_ST_ACCEL_3AXIS) selects
 IIO_ST_ACCEL_I2C_3AXIS which has unmet direct dependencies (IIO && ..)
Message-ID: <201701060422.ANenCkLe%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git lis3lv02
head:   e343deae8006a1fc109534497c943eab51a1c2a8
commit: 0a9710dd480b06b6fefefdedc732020f2297e247 [5/6] iio: accel: st_accel: handle deprecated bindings
config: x86_64-randconfig-x008-201701 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 0a9710dd480b06b6fefefdedc732020f2297e247
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

warning: (IIO_ST_ACCEL_3AXIS) selects IIO_ST_ACCEL_I2C_3AXIS which has unmet direct dependencies (IIO && !SENSORS_LIS3_I2C && IIO_ST_ACCEL_3AXIS && IIO_ST_SENSORS_I2C)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27927 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170106/31be2ce4/attachment-0001.gz>

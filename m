From: lkp@intel.com (kbuild test robot)
Date: Thu, 17 May 2018 12:00:07 +0800
Subject: [PATCH v3 08/14] media: v4l: Add definitions for MPEG2 frame
 format and header metadata
In-Reply-To: <20180507124500.20434-9-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-9-paul.kocialkowski@bootlin.com>
Message-ID: <201805171117.7dfYXI2F%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florent,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linuxtv-media/master]
[also build test WARNING on v4.17-rc5 next-20180516]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Paul-Kocialkowski/Sunxi-Cedrus-driver-for-the-Allwinner-Video-Engine-using-media-requests/20180508-004955
base:   git://linuxtv.org/media_tree.git master
config: x86_64-acpi-redef (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

>> ./usr/include/linux/v4l2-controls.h:1082: found __[us]{8,16,32,64} type without #include <linux/types.h>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30376 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180517/fa20e902/attachment-0001.gz>

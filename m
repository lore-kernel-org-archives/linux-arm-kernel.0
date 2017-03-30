From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 31 Mar 2017 05:12:46 +0800
Subject: [arm:cec-v18 12/12] ERROR: "cec_get_edid_phys_addr"
 [drivers/gpu/drm/i2c/tda998x.ko] undefined!
Message-ID: <201703310539.UqIGyVmA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git cec-v18
head:   803726e5c035daf0a07ecb33e9dc41c38f75d82e
commit: 803726e5c035daf0a07ecb33e9dc41c38f75d82e [12/12] drm/i2c: tda998x: add CEC support
config: x86_64-rhel (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 803726e5c035daf0a07ecb33e9dc41c38f75d82e
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> ERROR: "cec_get_edid_phys_addr" [drivers/gpu/drm/i2c/tda998x.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38441 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170331/5a06b6dd/attachment-0001.gz>

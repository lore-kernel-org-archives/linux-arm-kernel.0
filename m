From: lkp@intel.com (kbuild test robot)
Date: Sun, 11 Dec 2016 08:14:04 +0800
Subject: [PATCH 3/3] crypto: brcm: Add Broadcom SPU driver DT entry.
In-Reply-To: <1480536453-24781-4-git-send-email-rob.rice@broadcom.com>
Message-ID: <201612110810.BEVbRp0B%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

[auto build test ERROR on cryptodev/master]
[also build test ERROR on v4.9-rc8]
[cannot apply to next-20161209]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Rob-Rice/crypto-brcm-DT-documentation-for-Broadcom-SPU-driver/20161202-010038
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> ERROR: Input tree has errors, aborting (use -f to force output)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31957 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161211/bead5da1/attachment-0001.gz>

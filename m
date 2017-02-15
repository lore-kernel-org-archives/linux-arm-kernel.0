From: lkp@intel.com (kbuild test robot)
Date: Thu, 16 Feb 2017 04:52:27 +0800
Subject: [PATCH V9 05/10] acpi: apei: handle SEA notification type for
 ARMv8
In-Reply-To: <1487180692-16732-6-git-send-email-tbaicar@codeaurora.org>
Message-ID: <201702160444.981pIc8k%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

[auto build test WARNING on pm/linux-next]
[also build test WARNING on v4.10-rc8 next-20170215]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tyler-Baicar/Add-UEFI-2-6-and-ACPI-6-1-updates-for-RAS-on-ARM64/20170216-020811
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

warning: (ARM64) selects HAVE_ACPI_APEI_SEA which has unmet direct dependencies (ACPI && ARM64 && ACPI_APEI_GHES)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33720 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170216/82217526/attachment-0001.gz>

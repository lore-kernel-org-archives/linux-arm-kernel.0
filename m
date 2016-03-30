From: lkp@intel.com (kbuild test robot)
Date: Wed, 30 Mar 2016 14:50:49 +0800
Subject: [PATCH v8] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <1459237458-12352-1-git-send-email-fu.wei@linaro.org>
Message-ID: <201603301450.pihQHWST%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on v4.6-rc1 next-20160330]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/fu-wei-linaro-org/acpi-apei-arm64-APEI-initial-support-for-aarch64/20160329-154730
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/core
config: arm64-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

warning: (ACPI_APEI) selects EFI which has unmet direct dependencies (OF && !CPU_BIG_ENDIAN)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 48380 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160330/177c7499/attachment-0001.obj>

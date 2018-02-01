From: lkp@intel.com (kbuild test robot)
Date: Thu, 1 Feb 2018 08:51:51 +0800
Subject: [PATCH 14/15] ARM: dts: ipq8074: Add pcie nodes
In-Reply-To: <1517202689-14212-15-git-send-email-sricharan@codeaurora.org>
References: <1517202689-14212-15-git-send-email-sricharan@codeaurora.org>
Message-ID: <201802010850.o9m7cPXA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sricharan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.15]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sricharan-R/ARM-dts-ipq-updates-to-enable-a-few-peripherals/20180201-061258
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/qcom/ipq8074.dtsi:235.19-20 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37419 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180201/e5ed418a/attachment-0001.gz>

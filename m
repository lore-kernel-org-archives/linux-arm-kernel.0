From: lkp@intel.com (kbuild test robot)
Date: Thu, 17 May 2018 21:31:47 +0800
Subject: [PATCH V6 10/12] ARM: dts: ipq8074: Add peripheral nodes
In-Reply-To: <1526475004-10341-11-git-send-email-sricharan@codeaurora.org>
References: <1526475004-10341-11-git-send-email-sricharan@codeaurora.org>
Message-ID: <201805172143.Ej5ox0Yj%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sricharan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.17-rc5]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sricharan-R/ARM-dts-ipq-updates-to-enable-a-few-peripherals/20180517-155124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the linux-review/Sricharan-R/ARM-dts-ipq-updates-to-enable-a-few-peripherals/20180517-155124 HEAD 1e054800261138fd8f0f8f93340f5781ff622233 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb: ERROR (duplicate_label): /soc/pinctrl at 1000000/serial4_pinmux: Duplicate label 'serial_4_pins' on /soc/pinctrl at 1000000/serial4_pinmux and /soc/pinctrl at 1000000/serial4-pinmux
>> ERROR: Input tree has errors, aborting (use -f to force output)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38151 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180517/78988781/attachment-0001.gz>

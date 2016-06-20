From: lkp@intel.com (kbuild test robot)
Date: Tue, 21 Jun 2016 06:53:13 +0800
Subject: [PATCH 8/8] arm64: dts: db820c: add support to external sd card.
In-Reply-To: <1466452907-23290-9-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <201606210654.D5Ed8YnA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.7-rc4 next-20160620]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Srinivas-Kandagatla/arm64-dts-db820c-Add-basic-board-support/20160621-041430
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi:13.1-9 Label or path msmgpio not found
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25985 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160621/39f1d1e1/attachment-0001.obj>

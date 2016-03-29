From: lkp@intel.com (kbuild test robot)
Date: Tue, 29 Mar 2016 11:41:54 +0800
Subject: [PATCH 1/4] ARM: dts: qcom: msm8974: Add USB gadget nodes
In-Reply-To: <1459215159-2576-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <201603291144.YJ71a5us%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

[auto build test ERROR on v4.6-rc1]
[also build test ERROR on next-20160329]
[cannot apply to robh/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Bjorn-Andersson/ARM-dts-qcom-msm8974-Add-USB-gadget-nodes/20160329-093758
config: arm-multi_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/qcom-msm8974.dtsi:510.19-20 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 37213 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160329/9864eb77/attachment-0001.obj>

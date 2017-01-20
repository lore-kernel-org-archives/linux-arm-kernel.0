From: lkp@intel.com (kbuild test robot)
Date: Fri, 20 Jan 2017 08:09:45 +0800
Subject: [PATCH 7/7] ARM: dts: stm32: Enable pwm1 and pwm3 for
 stm32f469-eval
In-Reply-To: <1484832854-6314-8-git-send-email-fabrice.gasnier@st.com>
Message-ID: <201701200823.eJdD6yGb%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrice,

[auto build test ERROR on next-20170119]
[cannot apply to iio/togreg robh/for-next v4.9-rc8 v4.9-rc7 v4.9-rc6 v4.10-rc4]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Fabrice-Gasnier/Add-support-for-triggered-buffer-mode-to-STM32-ADC/20170120-062214
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/stm32429i-eval.dts:179.1-9 Label or path timers1 not found
>> Error: arch/arm/boot/dts/stm32429i-eval.dts:193.1-9 Label or path timers3 not found
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 22227 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170120/507360bb/attachment-0001.gz>

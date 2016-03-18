From: lkp@intel.com (kbuild test robot)
Date: Fri, 18 Mar 2016 08:27:42 +0800
Subject: [PATCH v2 2/3] ARM: DTS: da850/am4372/am33xx: Use generic node
 name for ehrpwm
In-Reply-To: <1458252463-8821-3-git-send-email-fcooper@ti.com>
Message-ID: <201603180818.rtawXhxL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Franklin,

[auto build test ERROR on pwm/for-next]
[also build test ERROR on v4.5 next-20160317]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Franklin-S-Cooper-Jr/clk-ti-am335x-am4372-Add-tbclk-to-pwm-node/20160318-060938
base:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm for-next
config: arm-multi_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   ERROR (duplicate_label): Duplicate label 'ehrpwm1' on /ocp/epwmss at 48302000/ehrpwm at 48302200 and /ocp/epwmss at 48302000/pwm at 48302200
>> ERROR: Input tree has errors, aborting (use -f to force output)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 36561 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160318/1e5b85d6/attachment-0001.obj>

From: lkp@intel.com (kbuild test robot)
Date: Wed, 8 Jun 2016 20:23:39 +0800
Subject: [alsa-devel] [PATCH v4] ASoC: rockchip: Add machine driver for
 RK3399 GRU Boards
In-Reply-To: <1465384464-22395-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <201606082021.2A9vfgV0%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on v4.7-rc2 next-20160608]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Xing-Zheng/ASoC-rockchip-Add-machine-driver-for-RK3399-GRU-Boards/20160608-191723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All warnings (new ones prefixed by >>):

warning: (SND_SOC_RK3399_GRU_SOUND) selects SND_SOC_ROCKCHIP_I2S which has unmet direct dependencies (SOUND && !M68K && !UML && SND && SND_SOC && CLKDEV_LOOKUP && SND_SOC_ROCKCHIP)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 46475 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160608/ad33e32e/attachment-0001.obj>

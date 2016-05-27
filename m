From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 28 May 2016 04:08:51 +0800
Subject: [rjarzmik:work/ac97 4/7] warning: (SND_SOC_WM9713) selects
 AC97_BUS_COMPAT which has unmet direct dependencies (SOUND && ..)
Message-ID: <201605280449.Wn9zuWFS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/rjarzmik/linux work/ac97
head:   3350c2230e9e1331442724f919c86542d9668d4b
commit: 8715b68899fdeea2968c7760843a0f908b4def2c [4/7] ASoC: wm9713: add ac97 new bus support
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 8715b68899fdeea2968c7760843a0f908b4def2c
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All warnings (new ones prefixed by >>):

warning: (SND_SOC_WM9713) selects AC97_BUS_COMPAT which has unmet direct dependencies (SOUND && !M68K && !UML && SND && !AC97_BUS)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45947 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160528/1f394e09/attachment-0001.obj>

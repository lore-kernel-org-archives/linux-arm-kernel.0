From: lkp@intel.com (kbuild test robot)
Date: Fri, 28 Oct 2016 01:09:53 +0800
Subject: [PATCH V3 5/6] ARM: tegra: Add Tegra20 GMI support
In-Reply-To: <1477576872-2665-6-git-send-email-mirza.krak@gmail.com>
Message-ID: <201610280016.MiLeMJw9%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mirza,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.9-rc2 next-20161027]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Mirza-Krak/clk-tegra-add-TEGRA20_CLK_NOR-to-init-table/20161027-225528
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-davinci_all_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/tegra20.dtsi:1.1-8 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20355 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161028/4237b36b/attachment-0001.gz>

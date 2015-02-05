From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 6 Feb 2015 01:03:52 +0800
Subject: [baohua:sirf-3.18 2573/2782] sound/soc/sirf/atlas7-iacc.c:168:24:
 sparse: symbol 'atlas7_iacc_dai_ops' was not declared. Should it be static?
Message-ID: <201502060130.hszyNa1F%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux sirf-3.18
head:   d61ca44a1d96f134d35d31522ca8efb19a6e1451
commit: 81aba96393135459ac811ce78fe8f91a8b767b82 [2573/2782] ASoC: sirf: atlas7: Add internal audio codec controller driver
reproduce:
  # apt-get install sparse
  git checkout 81aba96393135459ac811ce78fe8f91a8b767b82
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/sirf/atlas7-iacc.c:168:24: sparse: symbol 'atlas7_iacc_dai_ops' was not declared. Should it be static?
   sound/soc/sirf/atlas7-iacc.c:482:27: sparse: incorrect type in initializer (incompatible argument 4 (different address spaces))
   sound/soc/sirf/atlas7-iacc.c:482:27:    expected int ( *copy )( ... )
   sound/soc/sirf/atlas7-iacc.c:482:27:    got int ( static [toplevel] *<noident> )( ... )

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation

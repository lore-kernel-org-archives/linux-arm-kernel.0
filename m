From: lkp@intel.com (kbuild test robot)
Date: Thu, 1 Oct 2015 02:52:46 +0800
Subject: [PATCH v2 4/4] ASOC: sunxi: Add support for the spdif block
In-Reply-To: <1443635458-8873-5-git-send-email-codekipper@gmail.com>
Message-ID: <201510010231.FvvWaROC%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcus,

[auto build test results on next-20150930 -- if it's inappropriate base, please ignore]

reproduce:
  # apt-get install sparse
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/sunxi/sun4i-spdif.c:207:6: sparse: symbol 'sun4i_snd_txctrl_on' was not declared. Should it be static?
>> sound/soc/sunxi/sun4i-spdif.c:231:6: sparse: symbol 'sun4i_snd_txctrl_off' was not declared. Should it be static?
>> sound/soc/sunxi/sun4i-spdif.c:451:28: sparse: incorrect type in initializer (different base types)
   sound/soc/sunxi/sun4i-spdif.c:451:28:    expected unsigned long long [unsigned] [usertype] formats
   sound/soc/sunxi/sun4i-spdif.c:451:28:    got restricted snd_pcm_format_t

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

From: lkp@intel.com (kbuild test robot)
Date: Sun, 25 Jun 2017 23:02:54 +0800
Subject: [PATCH v1 3/5] [media] stm32-dcmi: crop sensor image to match
 user resolution
In-Reply-To: <1498144371-13310-4-git-send-email-hugues.fruchet@st.com>
Message-ID: <201706252214.3z2NADlJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hugues,

[auto build test WARNING on linuxtv-media/master]
[also build test WARNING on next-20170623]
[cannot apply to v4.12-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hugues-Fruchet/Camera-support-on-STM32F746G-DISCO-board/20170625-204425
base:   git://linuxtv.org/media_tree.git master


coccinelle warnings: (new ones prefixed by >>)

>> drivers/media/platform/stm32/stm32-dcmi.c:808:2-3: Unneeded semicolon
   drivers/media/platform/stm32/stm32-dcmi.c:562:2-3: Unneeded semicolon
   drivers/media/platform/stm32/stm32-dcmi.c:762:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

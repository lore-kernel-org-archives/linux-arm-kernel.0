From: lkp@intel.com (kbuild test robot)
Date: Tue, 13 Mar 2018 20:52:26 +0800
Subject: [RESEND PATCH v1 3/6] i2c: i2c-stm32f7: Add initial SMBus
 protocols support
In-Reply-To: <1520852023-27083-4-git-send-email-pierre-yves.mordret@st.com>
References: <1520852023-27083-4-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <201803132034.7iIeYSyJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pierre-Yves,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v4.16-rc4]
[also build test WARNING on next-20180313]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pierre-Yves-MORDRET/Add-different-features-for-I2C/20180313-193102


coccinelle warnings: (new ones prefixed by >>)

>> drivers/i2c/busses/i2c-stm32f7.c:995:2-3: Unneeded semicolon
   drivers/i2c/busses/i2c-stm32f7.c:944:2-3: Unneeded semicolon
   drivers/i2c/busses/i2c-stm32f7.c:875:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
